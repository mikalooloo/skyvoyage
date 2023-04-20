extends AnimatedSprite

export (String) var animation_name = ""

func playAnimation():
	play(animation_name)

func endAnimation():
	stop()
	frame = get_sprite_frames().get_frame_count(animation_name)
	
func _on_CollisionArea_body_entered(body):
	if body.name == "Player":
		playAnimation()

func _on_AnimatedSprite_animation_finished():
	endAnimation()
	
