extends Node

# *** GAME STATE ***
signal pressed_play
signal pressed_shop
signal pressed_settings
signal pressed_mainmenu

# WARNING: WILL ERASE ALL PLAYER DATA
signal refresh_data

# *** PLAYER ***
signal player_hurt(attempt)
signal player_died
signal player_dying
signal player_slowed
signal player_reward

signal player_evaded_death

# *** SHOP ***
signal pressed_shop_item(item)
signal player_equipped_skin(frames, frame_speed, hitbox, movement)
signal player_equipped_powerup(name)

signal money_changed(change)

# *** OBSTACLES ***
signal obstacle_pos_invalid(obs)
