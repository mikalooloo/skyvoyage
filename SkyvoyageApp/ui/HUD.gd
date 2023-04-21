extends Control

func _ready():
	visible = false
	if Signals.connect("pressed_play",self,"_makeVisible") != 0:
		print("Error connecting to pressed_play in HUD")
	if Signals.connect("player_died",self,"_makeInvisible") != 0:
		print("Error connecting to player_died in HUD")

func _makeVisible():
	visible = true
	
func _makeInvisible():
	visible = false
