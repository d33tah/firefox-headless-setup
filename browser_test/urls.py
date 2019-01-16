import browser_test.views as views
from django.conf.urls import url

urlpatterns = [
    url(r'^', views.hello),
]
