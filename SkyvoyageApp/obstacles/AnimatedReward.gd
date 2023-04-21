extends AnimatedSprite

export (String) var animation_name = ""

var randomizer: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	randomizer.randomize()
	
func playAnimation():
	play(animation_name)

func endAnimation():
	stop()
	frame = get_sprite_frames().get_frame_count(animation_name)
	
func _on_CollisionArea_body_entered(body):
	if body.name == "Player":
		playAnimation()
		# 1 in 4 chance for a higher average coins earned
		if randomizer.randi_range(0,3) == 0:
			Signals.emit_signal("money_changed", randomizer.randi_range(4,8))
		else:
			Signals.emit_signal("money_changed", randomizer.randi_range(2,4))

func _on_AnimatedSprite_animation_finished():
	endAnimation()
	
