extends MarginContainer

# *** LEFT SIDE ***
onready var item_viewer = find_node("ItemViewer")
onready var name_label = find_node("NameLabel")
onready var description_label = find_node("DescriptionLabel")
onready var animated_sprite = find_node("AnimatedSprite")
onready var button = find_node("Button")

# *** RIGHT SIDE ***
onready var birds_display = find_node("BirdDisplay")

func _ready():
	if Signals.connect("pressed_shop",self,"_openShop") != 0:
		print("Error connecting to pressed_shop in Shop")
	if Signals.connect("pressed_shop_item",self,"_openItem") != 0:
		print("Error connecting to pressed_shop_item in Shop")
		
func _openShop():
	visible = true
	item_viewer.visible = false
	birds_display.updateShopDisplay("birds")

func _openItem(item):
	item_viewer.visible = true
	name_label.text = item.item_name
	description_label.text = item.item_description
	animated_sprite.frames = item.item_sprite.frames
	animated_sprite.animation = "fly"
	# if not owned, make sure button says "buy for x coins"
	# if owned, make sure button says "equip"
	
func _on_BackButton_pressed():
	Signals.emit_signal("pressed_mainmenu")
	hide()

func _on_Button_pressed():
	# if not owned, buy it
	
	# if owned, equip it
	# Signals.emit_signal("player_equipped_skin", animated_sprite.frames)
	pass # Replace with function body.