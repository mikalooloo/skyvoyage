extends Node2D

func _ready():
	Signals.connect("player_died",self,"_playerDied")
	
func _playerDied():
	print("they do be dead")
