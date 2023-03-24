extends Node

export (Obstacle.Position) var starting_position = Obstacle.Position.BOTTOM
export (Obstacle.Speed) var speed_setting = Obstacle.Speed.NORMAL

var speed: float = 75.0
	
func _ready():
	if Signals.connect("player_died",self,"_playerDied") != 0:
		print("Error connecting to player_died in MovingObstacle")
		
	self.position = Obstacle.get_starting_position(starting_position)
	
func _physics_process(delta):
	self.position.x -= speed * delta

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		Signals.emit_signal("player_died")

func _playerDied():
	queue_free()
