extends AnimatedSprite

export (String) var idle_anim_name = ""
export (String) var left_attack_anim_name = ""
export (String) var right_attack_anim_name = ""

onready var obstacle = find_node("Obstacle")
var killer = false

func _on_CollisionArea_body_entered(body):
	if body.name == "Player" and !killer:
		if !Inventory.preventDeath():
			Signals.emit_signal("player_dying","hurt")
			killer = true
		if (global_position - body.position).x > 0:
			play(left_attack_anim_name)
		else:
			play(right_attack_anim_name)

func _on_AnimatedSprite_animation_finished():
	if killer:
		Signals.emit_signal("player_died")
