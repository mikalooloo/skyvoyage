extends MarginContainer

func _ready():
	if Signals.connect("pressed_shop",self,"openShop") != 0:
		print("Error connecting to pressed_shop in Shop")
		
func openShop():
	visible = true

func _on_BackButton_pressed():
	Signals.emit_signal("pressed_mainmenu")
	hide()
