from django.shortcuts import render
from .models import Contrato
from rest_framework import viewsets
from .serializers import ContratoSerializer

class contratosViewSet(viewsets.ModelViewSet):
    ueryset = Contrato.objects.all()
    serializer_class = ContratoSerializer
