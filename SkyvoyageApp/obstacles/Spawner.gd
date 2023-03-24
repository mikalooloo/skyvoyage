extends Node2D

export (Array, PackedScene) var obstacles
export (Array) var speed = [
	50.0,
	65.0,
	75.0,
	85.0,
	100
]

onready var timer: Timer = $Timer

var random_obstacle: RandomNumberGenerator = RandomNumberGenerator.new()
var selected_obstacle_index: int = 0

func _on_Timer_timeout():
	random_obstacle.randomize()
	selected_obstacle_index = random_obstacle.randi_range(0,obstacles.size()-1)
	var tmp = obstacles[selected_obstacle_index].instance()
	tmp.speed = speed[tmp.speed_setting]
	add_child(tmp)
	$Timer.start(random_obstacle.randf_range(1.0,3.0))
