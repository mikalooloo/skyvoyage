extends Node

export (Array, Obstacle.Position) var starting_positions = [Obstacle.Position.BOTTOM]
export (bool) var variable_position = false
export (bool) var variable_size = false
export (Obstacle.Speed) var speed_setting = Obstacle.Speed.NORMAL
export (Obstacle.Effect) var effect = Obstacle.Effect.KILL

var speed: float = 75.0
var starting_position: int
var stopped: bool = false
var randomizer: RandomNumberGenerator = RandomNumberGenerator.new()

onready var _collisionArea: Area2D = $CollisionArea

func _ready():
	randomizer.randomize()
	if Signals.connect("player_dying",self,"stopObstacle") != 0:
		print("Error connecting to player_dying in MovingObstacle")
	if Signals.connect("player_died",self,"removeObstacle") != 0:
		print("Error connecting to player_died in MovingObstacle")
	
	self.position = Obstacle.get_starting_position(getPosition())
	if variable_position:
		self.position.y += randomizer.randf_range(-25.0,25.0)
	if variable_size:
		self.scale.y += randomizer.randf_range(-0.2,0.2)
	
func _physics_process(delta):
	if not stopped:
		self.position.x -= speed * delta

func getPosition():
	starting_position = starting_positions[randomizer.randi_range(0,starting_positions.size()-1)]
	return starting_position
	
func removeObstacle():
	queue_free()
	
func stopObstacle():
	stopped = true

func _on_CollisionArea_body_entered(body):
	if body.name == "Player":
		match effect:
			Obstacle.Effect.KILL:
				Signals.emit_signal("player_died")
			Obstacle.Effect.REWARD:
				Signals.emit_signal("player_reward")

func _on_SpawnArea_area_entered(area):
	if (area.get_name() == "SpawnArea"):
		Signals.emit_signal("obstacle_pos_invalid", self)


