from django.db import models


class Tutorial(models.Model):
    title = models.CharField(max_length=70, blank=False, default='')
    description = models.CharField(max_length=200,blank=False, default='')
    published = models.BooleanField(default=False)

class GeeksModel(models.Model): 
        # fields of the model 
    title = models.CharField(max_length = 200) 
    description = models.TextField() 
    last_modified = models.DateTimeField(auto_now_add = True) 
    img = models.ImageField(upload_to = "images/") 
    
    def __str__(self): 
        return self.title 
    
class Contact(models.Model):
    fullName = models.CharField("Full name", max_length=255, blank = True, null = True)
    email = models.EmailField()
    phone = models.CharField(max_length=20, blank = True, null = True)
    website = models.URLField(blank=True, null=True)

    def __str__(self):
        return self.fullName

class PerProfile(models.Model):
    personal_profile = models.TextField(blank=True, null=True)
    def __str__(self):
        return self.personal_profile
    
class WorkExperience(models.Model):
    company_name = models.CharField("Company Name", max_length=255, blank=True, null=True)
    start_date = models.CharField("Start Date", null=True, blank = True, max_length=255)
    end_date = models.CharField("End Date", null=True, blank=True, max_length=255)
    description = models.TextField(blank=True, null = True)

    def __str__(self):
        return self.company_name

class KeySkill(models.Model):
    key_skill = models.TextField("Skill", blank = True, null = True)

    def __str__(self):
        return self.key_skil
    
class Image(models.Model):
    title = models.CharField(max_length=200)
    image = models.ImageField(upload_to='images')
    def __str__(self):
        return self.title
