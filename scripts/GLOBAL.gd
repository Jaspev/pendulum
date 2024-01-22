extends Node

var plr_hp = 5
var money = 0
var score = 0
var kill_count = 0
var enemy_spawn_count = 0
var bosses_killed = 0

func reset():
	plr_hp = 5
	money = 0
	score = 0
	kill_count = 0
	enemy_spawn_count = 0
	bosses_killed = 0

func _input(event):
	if event.is_action_pressed("fullscreen"): # f11 fullscreens
		if DisplayServer.window_get_mode() == 0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
