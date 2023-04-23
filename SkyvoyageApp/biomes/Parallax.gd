extends ParallaxLayer

export (float) var speed = -15
var play = true

func _ready():
	if Signals.connect("player_died",self,"_startBackground"):
		print("Error connecting to pressed_play in Parallax")
	if Signals.connect("player_dying",self,"_stopBackground") != 0:
		print("Error connecting to player_died in Parallax")
		
func _process(delta):
	if play:
		self.motion_offset.x += speed * delta

func _startBackground():
	play = true

func _stopBackground(_animate):
	play = false
