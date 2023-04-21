extends CenterContainer

onready var item_sprite = find_node("AnimatedSprite")
onready var item_texture_rect = find_node("TextureRect")

var display_item

func displayItem(item):
	if item is Item:
		display_item = item
		if item.texture:
			item_texture_rect.texture = item.texture
		if item.sprite_frames:
			item_sprite.frames = item.sprite_frames
			item_sprite.animation = "fly"
			item_sprite.speed_scale = item.sprite_speed

func _on_Slot_gui_input(event):
	if event.is_action_pressed("ui_select"):
		Signals.emit_signal("pressed_shop_item", display_item)
