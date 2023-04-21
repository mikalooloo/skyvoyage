extends GridContainer

var shop = preload("res://shop/ShopItems.tres")

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
