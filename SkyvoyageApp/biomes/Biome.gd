extends Node2D

export (Array, float) var speeds = [
	0.05,
	0.1,
	0.15,
	0.2
]

onready var backgrounds = [
	get_node("ParallaxBackground/Layer1/Sprite1").get_material(),
	get_node("ParallaxBackground/Layer2/Sprite2").get_material(),
	get_node("ParallaxBackground/Layer3/Sprite3").get_material(),
	get_node("ParallaxBackground/Layer4/Sprite4").get_material(),
]

func _ready():
	if Signals.connect("player_died",self,"_startBackground"):
		print("Error connecting to pressed_play in Biome")
	if Signals.connect("player_dying",self,"_stopBackground") != 0:
		print("Error connecting to player_died in Biome")
	
func _startBackground():
	for i in range(0, backgrounds.size()):
		backgrounds[i].set_shader_param("scroll_speed", speeds[i])
	
func _stopBackground():
	for background in backgrounds:
		#var shader = background.get_material()
		background.set_shader_param("scroll_speed", 0)
