extends Node

export (Array, Obstacle.Position) var starting_positions = [Obstacle.Position.BOTTOM]
export (Obstacle.Speed) var speed_setting = Obstacle.Speed.NORMAL
export (Obstacle.Effect) var effect = Obstacle.Effect.KILL

var speed: float = 75.0
	
func _ready():
	if Signals.connect("player_died",self,"_playerDied") != 0:
		print("Error connecting to player_died in MovingObstacle")
		
	self.position = Obstacle.get_starting_position(starting_positions[getPosition()])
	
func _physics_process(delta):
	self.position.x -= speed * delta

func getPosition():
	var randomizer = RandomNumberGenerator.new()
	randomizer.randomize()
	return randomizer.randi_range(0,starting_positions.size()-1)
	
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		match effect:
			Obstacle.Effect.KILL:
				Signals.emit_signal("player_died")
			Obstacle.Effect.REWARD:
				Signals.emit_signal("player_reward")

func _playerDied():
	queue_free()
