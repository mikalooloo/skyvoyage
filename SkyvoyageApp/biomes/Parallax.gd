extends ParallaxLayer

export (float) var default_speed = -15.0
var speed = -15.0
var play = true

func _ready():
	speed = default_speed
	if Signals.connect("player_died",self,"_startBackground"):
		print("Error connecting to pressed_play in Parallax")
	if Signals.connect("player_dying",self,"_stopBackground") != 0:
		print("Error connecting to player_died in Parallax")
	if Signals.connect("difficulty_increase",self,"_increaseSpeed") != 0:
		print("Error connecting to difficulty_increase in Parallax")
		
func _process(delta):
	if play:
		self.motion_offset.x += speed * delta

func _startBackground():
	speed = default_speed
	play = true

func _stopBackground(_animate):
	play = false

func _increaseSpeed(increase):
	speed -= increase
