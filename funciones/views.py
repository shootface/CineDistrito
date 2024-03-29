from django.shortcuts import render
from .models import Pelicula, Funcion, FuncionSala
from multiplex.models import Multiplex, Sala
from reservas.models import SillaReservada
from multiplex.serializers import MultiplexSerializer
from rest_framework import viewsets
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from .serializers import *

# Create your views here.

class PeliculaViewSet(viewsets.ModelViewSet):
    queryset = Pelicula.objects.all()
    serializer_class = PeliculaSerializer


class FuncionViewSet(viewsets.ModelViewSet):
    queryset = Funcion.objects.all()

    def get_serializer_class(self):
        if self.request.method == 'POST':
            return FuncionPostSerializer
        elif self.request.method == 'GET':
            return FuncionGetSerializer

class FuncionSalaViewSet(viewsets.ModelViewSet):
    queryset = FuncionSala.objects.all()

    def get_serializer_class(self):
        if self.request.method == 'POST':
            return FuncionSalaPostSerializer
        elif self.request.method == 'GET':
            return FuncionSalaGetSerializer

class MultiplexPeliculasView(APIView):
    def get(self, request, pk_pelicula,format=None):
        funciones = Funcion.objects.filter(fk_pelicula=pk_pelicula)
        funciones_sala = FuncionSala.objects.filter(fk_funcion__in=funciones.all())
        salas = Sala.objects.filter(pk__in=funciones_sala.values('fk_sala'))
        multiplex = Multiplex.objects.filter(pk__in=salas.values('fk_multiplex'))
        serializer = MultiplexSerializer(multiplex, many=True)
        return Response(serializer.data)

class FuncionesMultiplexView(APIView):
    def get(self, request, pk_pelicula, pk_multiplex, format=None):
        salas = Sala.objects.filter(fk_multiplex=pk_multiplex)
        funciones = Funcion.objects.filter(fk_pelicula=pk_pelicula)
        funciones_sala = FuncionSala.objects.filter(fk_funcion__in=funciones.all()).filter(fk_sala__in=salas.all())
        serializer = FuncionSalaGetSerializer(funciones_sala, many=True)
        return Response(serializer.data)





