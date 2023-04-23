extends GridContainer

var shop = preload("res://shop/ShopItems.tres")

func _ready():
	if Signals.connect("reset_data",self,"_reset") != 0:
		print("Error connecting to reset_data in ItemsDisplay")
	
func _reset():
	var item = shop.birds[0]
	Inventory.equipSkin(item.name, item.sprite_frames, item.sprite_speed, item.sprite_body, item.sprite_move)
	
func updateShopDisplay(tab):
	match tab:
		"birds":
			for i in shop.birds.size():
				updateShopSlotDisplay(i, shop.birds[i])
		"powerups":
			for i in shop.powerups.size():
				updateShopSlotDisplay(i, shop.powerups[i])

func updateShopSlotDisplay(item_i, item):
	var shopSlotDisplay = get_child(item_i)
	shopSlotDisplay.displayItem(item)
