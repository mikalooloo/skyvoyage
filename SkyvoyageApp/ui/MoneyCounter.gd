extends HBoxContainer

onready var _label = $Label

func _ready():
	if Signals.connect("money_changed",self,"_updateCoins") != 0:
		print("Error connecting to money_changed in MoneyCounter")
		
func _updateCoins(_change):
	_label.text = str(Inventory.getCoins())
