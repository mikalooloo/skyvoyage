extends Node

var _coins = 0
var _currently_equipped_skin = "Blue Jay"
var _currently_equipped_powerup = ""
var _powerup_used = false
var _items = ["Blue Jay"]

var _alltime_highscore = 0
var _current_highscore = 0

func _ready():
	if Signals.connect("pressed_play",self,"_updateUses") != 0:
		print("Error connecting to pressed_play in Inventory")
	if Signals.connect("reset_data",self,"_clearInventory") != 0:
		print("Error connecting to reset_data in Inventory")
	if Signals.connect("money_changed",self,"_updateCoins") != 0:
		print("Error connecting to money_changed in Inventory")
	if Signals.connect("playtime_ended",self,"_updateHighscores") != 0:
		print("Error connecting to playtime_ended in Inventory")

func _updateUses():
	_powerup_used = false
	
func _clearInventory():
	_coins = 0
	_currently_equipped_skin = "Blue Jay"
	_currently_equipped_powerup = ""
	_items.clear()
	_items.append("Blue Jay")
	_current_highscore = 0

func _updateCoins(update):
	_coins += update

func getCoins():
	return _coins
	
func buyItem(item_name, item_cost):
	if _coins >= item_cost:
		Signals.emit_signal("money_changed", -item_cost)
		_items.append(item_name)
		return true
	return false

func hasItem(item_name):
	if item_name in _items:
		return true
	return false
	
func isEquipped(item_name):
	if _currently_equipped_skin == item_name or _currently_equipped_powerup == item_name:
		return true
	return false

func equipSkin(item_name, frames, frame_speed, hitbox, movement):
	_currently_equipped_skin = item_name
	Signals.emit_signal("player_equipped_skin", frames, frame_speed, hitbox, movement)

func equipPowerup(item_name, texture, frames, frame_speed):
	_currently_equipped_powerup = item_name
	Signals.emit_signal("player_equipped_powerup", item_name, texture, frames, frame_speed)
	
func unequipPowerup():
	_currently_equipped_powerup = ""
	Signals.emit_signal("player_equipped_powerup", "", null, null, 0)
	
func preventDeath():
	if _currently_equipped_powerup == "Extra Life" and !_powerup_used:
		_powerup_used = true
		Signals.emit_signal("player_used_powerup")
		return true
	return false

func getAllTimeHighscore():
	return _makeTimeText(_alltime_highscore)
	
func getCurrentHighscore():
	return _makeTimeText(_current_highscore)
	
func _makeTimeText(time):
	var seconds = fmod(time,60)
	var minutes = fmod(time, 3600) / 60
	var str_elapsed = "%02d:%02d" % [minutes, seconds]
	return str_elapsed
	
func _updateHighscores(time):
	if _alltime_highscore < time:
		_alltime_highscore = time
	if _current_highscore < time:
		_current_highscore = time
