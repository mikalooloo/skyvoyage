extends Node

# *** GAME STATE ***
signal pressed_play
signal pressed_shop
signal pressed_settings
signal pressed_mainmenu

# WARNING: WILL ERASE ALL PLAYER DATA
signal reset_data

# *** PLAYER ***
signal player_hurt(attempt)
signal player_died
signal player_dying(animation)
signal player_slowed
signal player_reward

signal player_used_powerup

# *** SHOP ***
signal pressed_shop_item(item)
signal player_equipped_skin(frames, frame_speed, hitbox, movement)
signal player_equipped_powerup(name, texture, frames, frame_speed)

signal money_changed(change)

# *** OBSTACLES ***
signal obstacle_pos_invalid(obs)
