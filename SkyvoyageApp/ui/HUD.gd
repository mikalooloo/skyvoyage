extends Control

onready var powerup = $Powerup
var grayscale_shader = preload("res://ui/Grayscale.tres")

onready var time_label = $Time
var tracking_time = false
var time = 0

var last_increase = 0

func _ready():
	visible = false
	if Signals.connect("pressed_play",self,"_makeVisible") != 0:
		print("Error connecting to pressed_play in HUD")
	if Signals.connect("player_dying",self,"_stopTimer") != 0:
		print("Error connecting to player_dying in HUD")
	if Signals.connect("player_died",self,"_makeInvisible") != 0:
		print("Error connecting to player_died in HUD")
	if Signals.connect("player_equipped_powerup",self,"_displayPowerup") != 0:
		print("Error connecting to player_equipped_powerup in HUD")
	if Signals.connect("player_used_powerup",self,"_makePowerupGray") != 0:
		print("Error connecting to player_used_powerup in HUD")
	if Signals.connect("reset_data",self,"_reset") != 0:
		print("Error connecting to reset_data in HUD")

func _process(delta):
	if tracking_time:
		time += delta
		time_label.text = Inventory._makeTimeText(time)
		var rounded_time = int(round(time))
		if rounded_time > 0 and rounded_time % 5 == 0 and last_increase != rounded_time:
			Signals.emit_signal("difficulty_increase", 5)
			last_increase = rounded_time
		
func _makeVisible():
	visible = true
	_resetPowerup()
	tracking_time = true
	
func _makeInvisible():
	visible = false
	time = 0
	
func _stopTimer(_animate):
	tracking_time = false
	Signals.emit_signal("playtime_ended",time)
	time = 0
	
func _reset():
	powerup.texture = null
	
func _displayPowerup(_name, texture, _frames, _frame_speed):
	powerup.texture = texture
	
func _resetPowerup():
	powerup.material = null
	
func _makePowerupGray():
	powerup.material = grayscale_shader
