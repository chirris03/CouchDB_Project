from django.shortcuts import render, get_object_or_404
from .models import Equipo, Jugador, JugadorPartido, JugadorPartidoPitcher

from .models import Equipo, EstadisticasLideres  # Import both models

from .models import Equipo, EstadisticasLideres  # Import both models

from .models import Equipo, EstadisticasLideres

def index(request):
    teams = Equipo.objects.all()
    statistics = EstadisticasLideres.objects.first()  

    context = {'teams': teams, 'statistics': statistics}
    return render(request, 'base/index.html', context)


def team_detail(request, team_id):
    team = get_object_or_404(Equipo, id_equipo=team_id)
    players = Jugador.objects.filter(equipo=team)
    context = {'team': team, 'players': players}
    return render(request, 'base/team_detail.html', context)


def player_detail(request, player_id):
    player = get_object_or_404(Jugador, id_jugador=player_id)
    
    # Fetch stats for both hitters and pitchers if they exist
    hitter_stats = JugadorPartido.objects.filter(jugador=player)
    pitcher_stats = JugadorPartidoPitcher.objects.filter(jugador=player)
    
    is_pitcher = hitter_stats.exists() and pitcher_stats.exists()
   
    return render(request, 'base/player_detail.html', {'player': player, 'hitter_stats': hitter_stats, 'pitcher_stats': pitcher_stats, 'is_pitcher': is_pitcher})

