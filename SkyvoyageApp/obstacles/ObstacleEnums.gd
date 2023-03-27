class_name Obstacle

enum Position {
	TOP,
	TOP_MIDDLE,
	MIDDLE,
	BOTTOM_MIDDLE,
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
		Position.BOTTOM:
			return Vector2(400, 182)
