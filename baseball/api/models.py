from django.db import models



class Equipo(models.Model):
    id_equipo = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=255, blank=True, null=True)
    ciudad = models.CharField(max_length=255, blank=True, null=True)
    fundación = models.DateField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'equipo'


class Jugador(models.Model):
    id_jugador = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=255, blank=True, null=True)
    apellido = models.CharField(max_length=255, blank=True, null=True)
    posición = models.CharField(max_length=50, blank=True, null=True)
    edad = models.IntegerField(blank=True, null=True)
    equipo = models.ForeignKey(Equipo, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'jugador'


class JugadorPartido(models.Model):
    id_jugador_partido = models.AutoField(primary_key=True)
    jugador = models.ForeignKey(Jugador, models.DO_NOTHING, blank=True, null=True)
    partido = models.ForeignKey('Partido', models.DO_NOTHING, blank=True, null=True)
    hits = models.IntegerField(blank=True, null=True)
    carreras_anotadas = models.IntegerField(blank=True, null=True)
    carreras_impulsadas = models.IntegerField(blank=True, null=True)
    bases_por_bolas = models.IntegerField(blank=True, null=True)
    ponches = models.IntegerField(blank=True, null=True)
    bases_robadas = models.IntegerField(blank=True, null=True)
    bases_defendidas = models.IntegerField(blank=True, null=True)
    turnos_al_bate = models.IntegerField(blank=True, null=True)
    home_runs_impulsados = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'jugador_partido'


class JugadorPartidoPitcher(models.Model):
    id_pitcher_stats = models.AutoField(primary_key=True)
    jugador = models.ForeignKey(Jugador, models.DO_NOTHING, blank=True, null=True)
    partido = models.ForeignKey('Partido', models.DO_NOTHING, blank=True, null=True)
    innings_lanzado = models.IntegerField(blank=True, null=True)
    hits_permitidos = models.IntegerField(blank=True, null=True)
    carreras = models.IntegerField(blank=True, null=True)
    bases_por_bola = models.IntegerField(blank=True, null=True)
    ponches = models.IntegerField(blank=True, null=True)
    home_runs = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'jugador_partido_pitcher'


class Partido(models.Model):
    id_partido = models.AutoField(primary_key=True)
    fecha = models.DateField(blank=True, null=True)
    lugar = models.CharField(max_length=255, blank=True, null=True)
    equipo_local = models.ForeignKey(Equipo, models.DO_NOTHING, blank=True, null=True)
    equipo_visitante = models.ForeignKey(Equipo, models.DO_NOTHING, related_name='partido_equipo_visitante_set', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'partido'

class EstadisticasLideres(models.Model):
    id = models.AutoField(primary_key=True)
    mejor_promedio_bateo = models.CharField(max_length=255)
    mejor_sbp = models.CharField(max_length=255)
    menor_era = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'estadisticas_lideres'
