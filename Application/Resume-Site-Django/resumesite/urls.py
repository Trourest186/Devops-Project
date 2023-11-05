from django.urls import path
from . import views
from django.conf.urls import url 
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('', views.home, name='home'),
    url(r'^api/resumesite$', views.tutorial_list),
    url(r'^api/resumesite/(?P<pk>[0-9]+)$', views.tutorial_detail),
    url(r'^api/resumesite/published$', views.tutorial_list_published),

    path('contacts/create/', views.create, name='change'),
    path('contacts/change/', views.change_form, name='change_form'),
    path('upload/', views.image_upload_view),
]
