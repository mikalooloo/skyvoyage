extends CenterContainer

onready var item_sprite = find_node("AnimatedSprite")
onready var item_texture_rect = find_node("TextureRect")

var item_name
var item_description
var item_cost

func displayItem(item):
	if item is Item:
		item_name = item.name
		item_description = item.description
		item_cost = item.cost
		if item.texture:
			item_texture_rect.texture = item.texture
		if item.sprite_frames:
			item_sprite.frames = item.sprite_frames
			item_sprite.animation = "fly"

func _on_Slot_gui_input(event):
	if event.is_action_pressed("ui_select"):
		Signals.emit_signal("pressed_shop_item", self)
