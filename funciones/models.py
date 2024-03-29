from django.db import models
from multiplex.models import Sala
# Create your models here.

class Funcion(models.Model):
    estados = (('activa', 'Activa'),
            ('inactiva', 'Inactiva'))

    v_estado = models.CharField('estado de la funcion', max_length=50, choices=estados)
    d_proyeccion = models.DateField('dia de proyeccion')
    fk_pelicula = models.ForeignKey(
        'Pelicula', 
        on_delete=models.CASCADE, 
        db_column='fk_pelicula',
        verbose_name='pelicula de la funcion'
    )
    t_inicioproyeccion = models.TimeField('hora de inicio')
    t_finproyeccion = models.TimeField('hora de finalizacion')

    def __str__(self):
        return str(self.id)+'-'+self.fk_pelicula.v_nombre
    

    class Meta:
        managed = True
        db_table = 'funcion'

class Pelicula(models.Model):
    v_nombre = models.CharField('nombre pelicula',max_length=150)
    i_duracion = models.IntegerField('duracion pelicula')
    tx_sinapsis = models.TextField('sinapsis pelicula')
    v_foto = models.ImageField('foto pelicula', upload_to='fotos-peliculas/')

    def __str__(self):
        return self.v_nombre
    

    class Meta:
        managed = True
        db_table = 'pelicula'

class FuncionSala(models.Model):
    fk_funcion = models.ForeignKey(Funcion, on_delete=models.CASCADE, db_column='fk_funcion')
    fk_sala = models.ForeignKey(Sala, on_delete=models.CASCADE, db_column='fk_sala')

    class Meta:
        managed = True
        db_table = 'funcion_sala'
        unique_together = (('fk_funcion', 'fk_sala'),)
    
    def __str__(self):
        return str(self.fk_funcion) + str(self.fk_sala)