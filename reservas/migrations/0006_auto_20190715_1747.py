# Generated by Django 2.2.1 on 2019-07-15 22:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('reservas', '0005_auto_20190715_1745'),
    ]

    operations = [
        migrations.AlterField(
            model_name='reserva',
            name='t_inicioreserva',
            field=models.DateTimeField(auto_now_add=True),
        ),
    ]
