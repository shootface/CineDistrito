# Generated by Django 2.2.1 on 2019-06-29 14:24

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Reserva',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('v_estado', models.CharField(max_length=50)),
                ('t_inicioreserva', models.TimeField()),
            ],
            options={
                'db_table': 'reserva',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='SillaReservada',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('v_estado', models.CharField(choices=[('proceso', 'En proceso'), ('reservada', 'Reservada')], max_length=50)),
            ],
            options={
                'db_table': 'silla_reservada',
                'managed': False,
            },
        ),
    ]