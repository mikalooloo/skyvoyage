extends MarginContainer

onready var tab_container = find_node("TabContainer")

# *** LEFT SIDE ***
onready var item_viewer = find_node("ItemViewer")
onready var name_label = find_node("NameLabel")
onready var description_label = find_node("DescriptionLabel")
onready var animated_sprite = find_node("AnimatedSprite")
onready var button = find_node("Button")

# *** RIGHT SIDE ***
onready var birds_display = find_node("BirdDisplay")

var current_item_name = ""
var current_item_cost = 0

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
	current_item_name = item.item_name
	name_label.text = item.item_name
	current_item_cost = item.item_cost
	description_label.text = item.item_description
	animated_sprite.frames = item.item_sprite.frames
	animated_sprite.animation = "fly"
	# if not owned, make sure button says "buy for x coins"
	if !Inventory.hasItem(current_item_name):
		button.text = "buy for " + str(item.item_cost) + " coins"
	else: # if owned, make sure button says "equip" or "equipped"
		if Inventory.isEquipped(current_item_name):
			button.text = "equipped"
		else:
			button.text = "equip"
	
func _on_BackButton_pressed():
	Signals.emit_signal("pressed_mainmenu")
	hide()

func _on_Button_pressed():
	button.release_focus()
	# if not owned, buy it
	if !Inventory.hasItem(current_item_name):
		if Inventory.buyItem(current_item_name, current_item_cost):
			button.text = "equip"
	else: # if owned, equip it
		button.text = "equipped"
		if tab_container.current_tab == 1:
			Inventory.equipSkin(current_item_name, animated_sprite.frames)
		else:
			Signals.emit_signal("player_equipped_powerup")
