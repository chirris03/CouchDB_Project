from django.contrib import admin
from .models import Equipo, Jugador, JugadorPartido, JugadorPartidoPitcher, Partido
from django.contrib import admin
from django.contrib.auth.models import Group, User


admin.site.unregister(Group)
admin.site.unregister(User)



# Registrar el modelo Equipo en la página de administración
class EquipoAdmin(admin.ModelAdmin):
    list_display = ('id_equipo', 'nombre', 'ciudad', 'fundación')

admin.site.register(Equipo, EquipoAdmin)

# Registrar el modelo Jugador en la página de administración
class JugadorAdmin(admin.ModelAdmin):
    list_display = ('id_jugador', 'nombre', 'apellido', 'posición', 'edad', 'equipo')

admin.site.register(Jugador, JugadorAdmin)

# Registrar el modelo JugadorPartido en la página de administración
class JugadorPartidoAdmin(admin.ModelAdmin):
    list_display = ('id_jugador_partido', 'jugador', 'partido', 'hits', 'carreras_anotadas', 'carreras_impulsadas', 'bases_por_bolas', 'ponches', 'bases_robadas', 'bases_defendidas', 'turnos_al_bate', 'home_runs_impulsados')

admin.site.register(JugadorPartido, JugadorPartidoAdmin)

# Registrar el modelo JugadorPartidoPitcher en la página de administración
class JugadorPartidoPitcherAdmin(admin.ModelAdmin):
    list_display = ('id_pitcher_stats', 'jugador', 'partido', 'innings_lanzado', 'hits_permitidos', 'carreras', 'bases_por_bola', 'ponches', 'home_runs')

admin.site.register(JugadorPartidoPitcher, JugadorPartidoPitcherAdmin)

# Registrar el modelo Partido en la página de administración
class PartidoAdmin(admin.ModelAdmin):
    list_display = ('id_partido', 'fecha', 'lugar', 'equipo_local', 'equipo_visitante')

admin.site.register(Partido, PartidoAdmin)