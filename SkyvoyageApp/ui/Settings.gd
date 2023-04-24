extends Control

onready var _alltime_highscore = find_node("Highscore0")
onready var _current_highscore = find_node("Highscore1")

func _ready():
	if Signals.connect("pressed_settings",self,"_openSettings") != 0:
		print("Error connecting to pressed_settings in Settings")
		
func _openSettings():
	visible = true
	_updateHighscores()
	
func _on_BackButton_pressed():
	Signals.emit_signal("pressed_mainmenu")
	hide()

func _on_ResetButton_pressed():
	Signals.emit_signal("reset_data")
	_current_highscore.text = "00:00"

func _updateHighscores():
	_alltime_highscore.text = Inventory.getAllTimeHighscore()
	_current_highscore.text = Inventory.getCurrentHighscore()
