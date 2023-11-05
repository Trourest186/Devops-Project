from rest_framework import serializers 
from resumesite.models import Tutorial

 
class TutorialSerializer(serializers.ModelSerializer):
 
    class Meta:
        model = Tutorial
        fields = ('id',
                  'title',
                  'description',
                  'published')
        
# Class GeeksModel isn't be added!