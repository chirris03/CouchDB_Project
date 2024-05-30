# Generated by Django 5.0.6 on 2024-05-29 21:10

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Equipo',
            fields=[
                ('id_equipo', models.AutoField(primary_key=True, serialize=False)),
                ('nombre', models.CharField(blank=True, max_length=255, null=True)),
                ('ciudad', models.CharField(blank=True, max_length=255, null=True)),
                ('fundación', models.DateField(blank=True, null=True)),
            ],
            options={
                'db_table': 'equipo',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Jugador',
            fields=[
                ('id_jugador', models.AutoField(primary_key=True, serialize=False)),
                ('nombre', models.CharField(blank=True, max_length=255, null=True)),
                ('apellido', models.CharField(blank=True, max_length=255, null=True)),
                ('posición', models.CharField(blank=True, max_length=50, null=True)),
                ('edad', models.IntegerField(blank=True, null=True)),
            ],
            options={
                'db_table': 'jugador',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='JugadorPartido',
            fields=[
                ('id_jugador_partido', models.AutoField(primary_key=True, serialize=False)),
                ('hits', models.IntegerField(blank=True, null=True)),
                ('carreras_anotadas', models.IntegerField(blank=True, null=True)),
                ('carreras_impulsadas', models.IntegerField(blank=True, null=True)),
                ('bases_por_bolas', models.IntegerField(blank=True, null=True)),
                ('ponches', models.IntegerField(blank=True, null=True)),
                ('bases_robadas', models.IntegerField(blank=True, null=True)),
                ('bases_defendidas', models.IntegerField(blank=True, null=True)),
                ('turnos_al_bate', models.IntegerField(blank=True, null=True)),
                ('home_runs_impulsados', models.IntegerField(blank=True, null=True)),
            ],
            options={
                'db_table': 'jugador_partido',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='JugadorPartidoPitcher',
            fields=[
                ('id_pitcher_stats', models.AutoField(primary_key=True, serialize=False)),
                ('innings_lanzado', models.IntegerField(blank=True, null=True)),
                ('hits_permitidos', models.IntegerField(blank=True, null=True)),
                ('carreras', models.IntegerField(blank=True, null=True)),
                ('bases_por_bola', models.IntegerField(blank=True, null=True)),
                ('ponches', models.IntegerField(blank=True, null=True)),
                ('home_runs', models.IntegerField(blank=True, null=True)),
            ],
            options={
                'db_table': 'jugador_partido_pitcher',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Partido',
            fields=[
                ('id_partido', models.AutoField(primary_key=True, serialize=False)),
                ('fecha', models.DateField(blank=True, null=True)),
                ('lugar', models.CharField(blank=True, max_length=255, null=True)),
            ],
            options={
                'db_table': 'partido',
                'managed': False,
            },
        ),
    ]
