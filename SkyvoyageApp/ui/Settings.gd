extends Control

func _ready():
	if Signals.connect("pressed_settings",self,"_openSettings") != 0:
		print("Error connecting to pressed_settings in Settings")
		
func _openSettings():
	visible = true
	
func _on_BackButton_pressed():
	Signals.emit_signal("pressed_mainmenu")
	hide()

func _on_ResetButton_pressed():
	Signals.emit_signal("reset_data")
