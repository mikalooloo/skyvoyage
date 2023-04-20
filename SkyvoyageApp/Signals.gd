extends Node

# *** GAME STATE ***
signal pressed_play
signal pressed_shop
signal pressed_settings
signal pressed_mainmenu

# WARNING: WILL ERASE ALL PLAYER DATA
signal refresh_data

# *** PLAYER ***
signal player_hurt
signal player_died
signal player_dying
signal player_slowed
signal player_reward

# *** SHOP ***
signal pressed_shop_item(item)
signal player_equipped_skin(frames)
signal player_equipped_powerup(powerup)

# *** OBSTACLES ***
signal obstacle_pos_invalid(obs)
