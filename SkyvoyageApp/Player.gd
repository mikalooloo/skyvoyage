extends KinematicBody2D

# *** MOVEMENT ***
const ACCELERATION: int = 700
const MAX_SPEED: int = 200
const FRICTION: int = 800

var velocity: Vector2 = Vector2.ZERO
var dying: bool = false

# *** SPRITES ***
onready var animation: AnimatedSprite = $AnimatedSprite
onready var playerBody: CollisionShape2D = $PlayerBody

# *** METHODS ***
func _ready():
	# gameplay signals
	if Signals.connect("pressed_play",self,"_spawn") != 0:
		print("Error connecting to pressed_play in Player")
	if Signals.connect("player_dying",self,"_dying") != 0:
		print("Error connecting to player_dying in Player")
	if Signals.connect("player_died",self,"_die") != 0:
		print("Error connecting to player_died in Player")
	# shop signals
	if Signals.connect("player_equipped_skin",self,"_equipSkin") != 0:
		print("Error connecting to player_equipped_skin in Player")

func _spawn():
	position = Vector2(75, 45)
	visible = true
	animation.play("fly")
	
func _dying():
	dying = true
	velocity = Vector2.ZERO
	animation.stop()
	animation.play("hurt")
	
func _die():
	dying = false
	visible = false
	velocity = Vector2.ZERO

func _equipSkin(frames, frame_speed, hitbox, movement):
	animation.position = movement
	animation.frames = frames
	animation.speed_scale = frame_speed
	animation.animation = "fly"
	playerBody.shape = hitbox
	
func _physics_process(delta):
	if visible and not dying:
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		input_vector = input_vector.normalized()
		
		if input_vector != Vector2.ZERO:
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		else:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
				
		velocity = move_and_slide(velocity)

func _on_AnimatedSprite_animation_finished():
	if dying:
		animation.stop()
		animation.frame = animation.get_sprite_frames().get_frame_count("die")
