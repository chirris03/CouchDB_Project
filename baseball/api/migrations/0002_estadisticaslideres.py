# Generated by Django 5.0.6 on 2024-05-30 00:02

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='EstadisticasLideres',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('mejor_promedio_bateo', models.CharField(max_length=255)),
                ('mejor_sbp', models.CharField(max_length=255)),
                ('menor_era', models.CharField(max_length=255)),
            ],
            options={
                'db_table': 'estadisticas_lideres',
                'managed': False,
            },
        ),
    ]
