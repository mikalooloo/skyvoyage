extends MarginContainer

onready var tab_container = find_node("TabContainer")

# *** LEFT SIDE ***
onready var item_viewer = find_node("ItemViewer")
onready var name_label = find_node("NameLabel")
onready var description_label = find_node("DescriptionLabel")
onready var animated_sprite = find_node("AnimatedSprite")
onready var item_button = find_node("Button")

# *** RIGHT SIDE ***
onready var birds_display = find_node("BirdDisplay")

var current_item

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
	current_item = item
	name_label.text = item.name
	description_label.text = item.description
	animated_sprite.frames = item.sprite_frames
	animated_sprite.animation = "fly"
	# if not owned, make sure button says "buy for x coins"
	if !Inventory.hasItem(item.name):
		item_button.text = "buy for " + str(item.cost) + " coins"
	else: # if owned, make sure button says "equip" or "equipped"
		if Inventory.isEquipped(item.name):
			item_button.text = "equipped"
		else:
			item_button.text = "equip"
	
func _on_BackButton_pressed():
	Signals.emit_signal("pressed_mainmenu")
	hide()

func _on_Button_pressed():
	item_button.release_focus()
	# if not owned, buy it
	if !Inventory.hasItem(current_item.name):
		if Inventory.buyItem(current_item.name, current_item.cost):
			item_button.text = "equip"
	else: # if owned, equip it
		item_button.text = "equipped"
		if tab_container.current_tab == 1:
			Inventory.equipSkin(current_item.name, 
				current_item.sprite_frames, current_item.sprite_speed, current_item.sprite_body, current_item.sprite_move)
		else:
			Signals.emit_signal("player_equipped_powerup")


func _on_MoneyCounter_gui_input(event):
	if event.is_action_pressed("ui_select"):
		Signals.emit_signal("money_changed", 1)
