extends MarginContainer

onready var play_button: Button = find_node("PlayButton")

# *** STARTING GAME ***

func _ready():
	if Signals.connect("pressed_mainmenu",self,"openMenu") != 0:
		print("Error connecting to pressed_mainmenu in MainMenu")
	if Signals.connect("player_died",self,"openMenu") != 0:
		print("Error connecting to player_died in MainMenu")
		
	openMenu()

func openMenu():
	visible = true
	play_button.grab_focus()
	
func _on_PlayButton_pressed():
	Signals.emit_signal("pressed_play")
	hide()

func _on_ShopButton_pressed():
	Signals.emit_signal("pressed_shop")
	hide()

func _on_SettingsButton_pressed():
	Signals.emit_signal("pressed_settings")
	hide()

func _on_QuitButton_pressed():
	get_tree().quit()
