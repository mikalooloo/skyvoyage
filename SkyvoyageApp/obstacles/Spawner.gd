extends Node2D

export (Array, PackedScene) var obstacles
export (Array) var speed = [
	50.0,
	65.0,
	75.0,
	85.0,
	100
]

onready var timer: Timer = find_node("Timer")

var random_obstacle: RandomNumberGenerator = RandomNumberGenerator.new()
var selected_obstacle_index: int = 0

func _ready():
	if Signals.connect("player_died",self,"_stopSpawning") != 0:
		print("Error connecting to player_died in Spawner")
	if Signals.connect("pressed_play",self,"_startSpawning") != 0:
		print("Error connecting to pressed_play in Spawner")
	
func _stopSpawning():
	timer.stop()
	
func _startSpawning():
	spawnObstacle()
	startTimer(2.0,3.0)
	
func _on_Timer_timeout():
	spawnObstacle()
	startTimer()

func spawnObstacle():
	random_obstacle.randomize()
	selected_obstacle_index = random_obstacle.randi_range(0,obstacles.size()-1)
	var tmp = obstacles[selected_obstacle_index].instance()
	tmp.speed = speed[tmp.speed_setting]
	add_child(tmp)
	
func startTimer(low=1.0,high=3.0):
	timer.start(random_obstacle.randf_range(low,high))
