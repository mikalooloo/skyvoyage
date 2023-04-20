class_name Obstacle

enum Position {
	TOP,
	MIDDLE,
	BOTTOM
}

enum Speed {
	VERY_SLOW,
	SLOW,
	NORMAL,
	FAST,
	VERY_FAST
}

enum Effect {
	STOP,
	KILL,
	REWARD
}

static func get_starting_position(StartingPosition):
	match (StartingPosition):
		Position.TOP:
			return Vector2(400,0)
		Position.MIDDLE:
			return Vector2(400, 50)
		Position.BOTTOM:
			return Vector2(400, 182)
