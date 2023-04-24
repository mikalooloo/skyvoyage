extends AudioStreamPlayer2D

onready var menu = load("res://assets/audio/2016_ Clement Panchout_ Life is full of Joy.wav")
onready var game = load("res://assets/audio/DavidKBD - HexaPuppies Pack - 06 - Icecap Mountains - 1.ogg")

onready var tween = $Tween

var fading_out = false
var current = "menu"

func _ready():
	if Signals.connect("pressed_play",self,"_playGameMusic") != 0:
		print("Error connecting to pressed_play in Audio")
	if Signals.connect("player_died",self,"_playMenuMusic") != 0:
		print("Error connecting to player_died in Audio")

func _playGameMusic():
	fading_out = true
	current = "game"
	_fade_out()
	
func _playMenuMusic():
	fading_out = true
	current = "menu"
	_fade_out()
	
func _fade_out():
	tween.interpolate_property(self, "volume_db", 0, -80, 1.0, 1, Tween.EASE_IN, 0)
	tween.start()

func _fade_in():
	tween.interpolate_property(self, "volume_db", -80, 0, 1.0, 1, Tween.EASE_IN, 0)
	tween.start()
	
func _on_Tween_tween_completed(object, key):
	if fading_out:
		object.stop()
		match current:
			"menu":
				stream = menu
			"game":
				stream = game
		fading_out = false
		playing = true
		_fade_in()
