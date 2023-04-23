extends HBoxContainer

onready var _label = $Label

func _ready():
	if Signals.connect("money_changed",self,"_updateCoins") != 0:
		print("Error connecting to money_changed in MoneyCounter")
	if Signals.connect("reset_data",self,"_resetCoins") != 0:
		print("Error connecting to reset_data in MoneyCounter")
		
func _resetCoins():
	_label.text = "0"
	
func _updateCoins(_change):
	_label.text = str(Inventory.getCoins())
