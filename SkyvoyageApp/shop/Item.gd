extends Resource
class_name Item

export (String) var name = ""
export (SpriteFrames) var sprite_frames
export (CapsuleShape2D) var sprite_body
export (float) var sprite_speed = 1.5
export (Vector2) var sprite_move = Vector2.ZERO
export (Texture) var texture
export (String) var description = ""
export (int) var cost = 0
