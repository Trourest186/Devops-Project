from django.shortcuts import render, redirect, get_object_or_404
from django.http.response import JsonResponse
from rest_framework.parsers import JSONParser 
from rest_framework import status
from resumesite.models import Tutorial
from resumesite.serializers import TutorialSerializer
from rest_framework.decorators import api_view
from .forms import *
from .models import *
from django.views.generic import ListView, DetailView
import os
from shutil import copyfile, rmtree

# Create your views here.

def home(request):
    return render(request, 'home.html', {})

@api_view(['GET', 'POST', 'DELETE'])
def tutorial_list(request):
    # GET list of tutorials, POST a new tutorial, DELETE all tutorials
    if request.method == 'GET':
        tutorials = Tutorial.objects.all()
      
        title = request.GET.get('title', None)
        if title is not None:
            tutorials = tutorials.filter(title__icontains=title)
      
        tutorials_serializer = TutorialSerializer(tutorials, many=True)
        return JsonResponse(tutorials_serializer.data, safe=False)
  
    elif request.method == 'POST':
        tutorial_data = JSONParser().parse(request)
        tutorial_serializer = TutorialSerializer(data=tutorial_data)

        if tutorial_serializer.is_valid():
            tutorial_serializer.save()
            return JsonResponse(tutorial_serializer.data, status=status.HTTP_201_CREATED) 
        return JsonResponse(tutorial_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    elif request.method == 'DELETE':
        count = Tutorial.objects.all().delete()
        return JsonResponse({'message': '{} Tutorials were deleted successfully!'.format(count[0])}, status=status.HTTP_204_NO_CONTENT)

@api_view(['GET', 'PUT', 'DELETE'])
def tutorial_detail(request, pk):
    # find tutorial by pk (id)
    try: 
        tutorial = Tutorial.objects.get(pk=pk) 
        
        if request.method == 'GET': 
            tutorial_serializer = TutorialSerializer(tutorial) 
            return JsonResponse(tutorial_serializer.data)
        
        elif request.method == 'PUT': 
            tutorial_data = JSONParser().parse(request) 
            tutorial_serializer = TutorialSerializer(tutorial, data=tutorial_data) 
            if tutorial_serializer.is_valid(): 
                tutorial_serializer.save() 
                return JsonResponse(tutorial_serializer.data) 
            return JsonResponse(tutorial_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        
        elif request.method == 'DELETE': 
            tutorial.delete() 

            return JsonResponse({'message': 'Tutorial was deleted successfully!'}, status=status.HTTP_204_NO_CONTENT)

    except Tutorial.DoesNotExist: 
        return JsonResponse({'message': 'The tutorial does not exist'}, status=status.HTTP_404_NOT_FOUND)

@api_view(['GET'])
def tutorial_list_published(request):
    tutorials = Tutorial.objects.filter(published=True)
        
    if request.method == 'GET': 
        tutorials_serializer = TutorialSerializer(tutorials, many=True)
        return JsonResponse(tutorials_serializer.data, safe=False)
    
# Create your views here. 
def resume_change(request): 
    context ={} 
    context['form']= GeeksForm() 
    return render(request, "update.html", context) 

@api_view(['GET', 'POST'])
def create(request):
    form_type = request.GET.get('form_type')
    print(form_type)

    # Delete data in databases
    Contact.objects.all().delete()
    PerProfile.objects.all().delete()
    WorkExperience.objects.all().delete()
    KeySkill.objects.all().delete()

    if form_type == 'contact':
        print("hello1")
        form = ContactForm(request.POST)
        print("-----" + str(form))
        if form.is_valid():
            form.save()
            contact = Contact.objects.first()
            return render(request, 'home.html', {'form': form, 'contact': contact})
        
    elif form_type == 'per_profile':
        print("hello2")
        form = PerProfileForm(request.POST)
        print("-----" + str(form))
        if form.is_valid():
            form.save()
            per_profile = PerProfile.objects.first()
            return render(request, 'home.html', {'form': form, 'per_profile': per_profile})
        
    elif form_type == 'work_experience':
        print("hello3")
        form = WorkExperienceForm(request.POST)
        if form.is_valid():
            form.save()
            work = WorkExperience.objects.first()
            return render(request, 'home.html', {'form': form, 'work': work})

    elif form_type == 'key_skill':
        print("hello4")
        form = KeySkillForm(request.POST)
        if form.is_valid():
            form.save()
            skills = KeySkill.objects.all() # don't add
            return render(request, 'home.html', {'form': form, 'skills': skills})

    elif form_type == "upload_image":
        print("hello5")
        form = ImageForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            img_obj = form.instance

            source_dir = 'images/'
            dest_dir = 'static/images/'
            for filename in os.listdir(source_dir):
                source_path = os.path.join(source_dir, filename)
                dest_path = os.path.join(dest_dir, filename)
                copyfile(source_path, dest_path)

            # Delete contents of /images/ directory
            rmtree(source_dir)

            return render(request, 'home.html', {'form': form, 'image': img_obj})

    else:
        print("hello5")
        form = ContactForm()
        contact = Contact.objects.first() #None
        return render(request, 'home.html', {'form': form, 'contact': contact})
    
@api_view(['GET', 'POST'])
def change_form(request):
    if request.method == 'POST':
        form_type = request.POST.get('form_type')

        # Tùy thuộc vào giá trị form_type, render ra các form tương ứng
        if form_type == 'contact':
            form = ContactForm()
        elif form_type == 'per_profile':
            form = PerProfileForm()
        elif form_type == 'work_experience':
            form = WorkExperienceForm()
        elif form_type == 'key_skill':
            form = KeySkillForm()
        elif form_type == 'upload_image':
            form = ImageForm()
        # Thêm các trường hợp khác nếu có nhiều loại form hơn

        return render(request, 'form.html', {'form': form, 'form_type': form_type})
    else:
        return render(request, 'create.html')

@api_view(['POST'])
def image_upload_view(request):
    """Process images uploaded by users"""
    if request.method == 'POST':
        form = ImageForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            # Get the current instance object to display in the template

            img_obj = form.instance

             # Copy resources from /images/ to /static/images/
            source_dir = 'images/'
            dest_dir = 'static/images/'
            for filename in os.listdir(source_dir):
                source_path = os.path.join(source_dir, filename)
                dest_path = os.path.join(dest_dir, filename)
                copyfile(source_path, dest_path)

            # Delete contents of /images/ directory
            rmtree(source_dir)

            return render(request, 'index.html', {'form': form, 'img_obj': img_obj})
    else:
        form = ImageForm()    
        return render(request, 'index.html', {'form': form})