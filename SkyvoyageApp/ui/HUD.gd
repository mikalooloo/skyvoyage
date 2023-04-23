extends Control

onready var powerup = $Powerup
var grayscale_shader = preload("res://ui/Grayscale.tres")

func _ready():
	visible = false
	if Signals.connect("pressed_play",self,"_makeVisible") != 0:
		print("Error connecting to pressed_play in HUD")
	if Signals.connect("player_died",self,"_makeInvisible") != 0:
		print("Error connecting to player_died in HUD")
	if Signals.connect("player_equipped_powerup",self,"_displayPowerup") != 0:
		print("Error connecting to player_equipped_powerup in HUD")
	if Signals.connect("player_used_powerup",self,"_makePowerupGray") != 0:
		print("Error connecting to player_used_powerup in HUD")
	if Signals.connect("reset_data",self,"_reset") != 0:
		print("Error connecting to reset_data in HUD")

func _makeVisible():
	visible = true
	_resetPowerup()
	
func _makeInvisible():
	visible = false
	
func _reset():
	powerup.texture = null
	
func _displayPowerup(_name, texture, _frames, _frame_speed):
	powerup.texture = texture
	
func _resetPowerup():
	powerup.material = null
	
func _makePowerupGray():
	powerup.material = grayscale_shader
