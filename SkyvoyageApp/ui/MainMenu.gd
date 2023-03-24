extends MarginContainer

signal pressed_start
signal pressed_shop
signal pressed_settings

onready var playButton: Button = find_node("PlayButton")

# *** STARTING GAME ***

func _ready():
	playButton.grab_focus()

func _on_PlayButton_pressed():
	emit_signal("pressed_start")
	hide()

func _on_ShopButton_pressed():
	emit_signal("pressed_shop")
	hide()

func _on_SettingsButton_pressed():
	emit_signal("pressed_settings")
	hide()

func _on_QuitButton_pressed():
	get_tree().quit()
