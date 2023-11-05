from django import forms 
from .models import *
    
# creating a form   
class GeeksForm(forms.ModelForm): 
    # specify the name of model to use 
    class Meta: 
        model = GeeksModel 
        fields = "__all__"

class ContactForm(forms.ModelForm):
    class Meta:
        model = Contact
        fields = "__all__"

class PerProfileForm(forms.ModelForm):
    class Meta:
        model = PerProfile
        fields = "__all__"

class WorkExperienceForm(forms.ModelForm):
    class Meta:
        model = WorkExperience
        fields = "__all__"

class KeySkillForm(forms.ModelForm):
    class Meta:
        model = KeySkill
        fields = "__all__"

class ImageForm(forms.ModelForm):
    """Form for the image model"""
    class Meta:
        model = Image
        fields = ('title', 'image')

