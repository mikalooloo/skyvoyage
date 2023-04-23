extends Node2D

# This way each biome's spawner can have different obstacles
export (Array, PackedScene) var top_obstacles
export (Array, PackedScene) var middle_obstacles
export (Array, PackedScene) var bottom_obstacles
export (Array, PackedScene) var rewards
# And each biome has different definitions of speed
export (Array) var speed = [
	50.0,
	65.0,
	75.0,
	85.0,
	100
]

onready var obstacles_list = [top_obstacles, middle_obstacles, bottom_obstacles]
onready var obstacle_timer: Timer = $ObstacleTimer

var randomizer: RandomNumberGenerator = RandomNumberGenerator.new()
var selected_obstacle_index: int = 0
var last_selected_obstacle_indexes = [-1,-1]
var last_position = Obstacle.Position.TOP
var last_obstacle

func _ready():
	randomizer.randomize()
	if Signals.connect("player_died",self,"_stopSpawning") != 0:
		print("Error connecting to player_died in Spawner")
	if Signals.connect("player_dying",self,"_stopSpawning") != 0:
		print("Error connecting to player_dying in Spawner")
	if Signals.connect("pressed_play",self,"_startSpawning") != 0:
		print("Error connecting to pressed_play in Spawner")
	if Signals.connect("obstacle_pos_invalid",self,"_moveObstacle") != 0:
		print("Error connecting to obstacle_pos_invalid in Spawner")

func _stopSpawning(_animate = null):
	obstacle_timer.stop()
	last_obstacle = null
	
func _startSpawning():
	_spawnObstacle()
	_startObstacleTimer(1.0,2.0)
	#startRewardTimer()
	
# *** OBSTACLES ***
func _moveObstacle(obs):
	# if last obstacle created
	if last_obstacle == obs:
		obs.removeObstacle()
		_stopSpawning()
		_startSpawning()
	
func _startObstacleTimer(low=0.5,high=1.0):
	obstacle_timer.start(randomizer.randf_range(low,high))
	
func _on_ObstacleTimer_timeout():
	if (randomizer.randi_range(0,5) != 0):
		_spawnObstacle()
	else:
		_spawnReward()
	_startObstacleTimer(0.1,0.5)

func _setupChild(newChild):
	var tmp = newChild.instance()
	tmp.speed = speed[3]
	last_obstacle = tmp
	call_deferred("add_child",tmp)
	
func _spawnObstacle():
	# Get whether we're spawning a top/middle/bottom obstacle
	var pos: int
	if last_obstacle:
		pos = last_obstacle.starting_position
		while last_obstacle.starting_position == pos:
			#pos = randomizer.randi_range(0,Obstacle.Position.size()-2)
			pos = randomizer.randi_range(0,Obstacle.Position.size()-1)
	else:
		#pos = randomizer.randi_range(0,Obstacle.Position.size()-2)
		pos = randomizer.randi_range(0,Obstacle.Position.size()-1)
	var obstacles = obstacles_list[pos]
	# Get which specific obstacle we're spawning
	selected_obstacle_index = last_selected_obstacle_indexes[1]
	while selected_obstacle_index == last_selected_obstacle_indexes[1]:
		selected_obstacle_index = randomizer.randi_range(0,obstacles.size()-1)
	last_selected_obstacle_indexes[1] = last_selected_obstacle_indexes[0]
	last_selected_obstacle_indexes[0] = selected_obstacle_index
	_setupChild(obstacles[selected_obstacle_index])

# *** REWARDS ***
func _spawnReward():
	var selected_reward_index = randomizer.randi_range(0,rewards.size()-1)
	_setupChild(rewards[selected_reward_index])

