# Generated by Django 2.2.1 on 2019-06-29 17:58

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('usuarios', '__first__'),
        ('multiplex', '__first__'),
    ]

    operations = [
        migrations.CreateModel(
            name='Contrato',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('v_tipocontrato', models.CharField(max_length=100)),
                ('d_iniciocontrato', models.DateField()),
                ('i_salario', models.IntegerField()),
            ],
            options={
                'db_table': 'contrato',
                'managed': True,
            },
        ),
        migrations.CreateModel(
            name='Empleado',
            fields=[
                ('fk_persona', models.OneToOneField(db_column='fk_persona', on_delete=django.db.models.deletion.CASCADE, primary_key=True, serialize=False, to=settings.AUTH_USER_MODEL)),
                ('fk_contrato', models.IntegerField()),
                ('n_descuento', models.DecimalField(decimal_places=2, max_digits=4)),
                ('fk_numcontrato', models.ForeignKey(db_column='fk_numcontrato', on_delete=django.db.models.deletion.CASCADE, to='empleados.Contrato')),
            ],
            options={
                'db_table': 'empleado',
                'managed': True,
            },
        ),
        migrations.CreateModel(
            name='EmpleadoMultiplex',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('f_transferencia', models.DateTimeField()),
                ('fk_empleado', models.ForeignKey(db_column='fk_empleado', on_delete=django.db.models.deletion.CASCADE, to='empleados.Empleado')),
                ('fk_multiplex', models.ForeignKey(db_column='fk_multiplex', on_delete=django.db.models.deletion.CASCADE, to='multiplex.Multiplex')),
            ],
            options={
                'db_table': 'empleado_multiplex',
                'managed': True,
            },
        ),
    ]
