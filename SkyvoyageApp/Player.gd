extends KinematicBody2D

# *** MOVEMENT ***
const ACCELERATION: int = 700
const MAX_SPEED: int = 200
const FRICTION: int = 800

var velocity: Vector2 = Vector2.ZERO

# *** SPRITES ***
onready var animation: AnimatedSprite = $AnimatedSprite

# *** METHODS ***
func _ready():
	if Signals.connect("pressed_play",self,"spawn") != 0:
		print("Error connecting to pressed_play in Player")
	if Signals.connect("player_died",self,"die") != 0:
		print("Error connecting to player_died in Player")
		
func spawn():
	position = Vector2(8, 72)
	visible = true
	
func die():
	visible = false
	velocity = Vector2.ZERO

func _physics_process(delta):
	if visible:
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		input_vector = input_vector.normalized()
		
		if input_vector != Vector2.ZERO:
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		else:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
				
		velocity = move_and_slide(velocity)
