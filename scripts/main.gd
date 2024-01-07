extends Node2D

func _ready():
	pass 
	
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("fullscreen"): # f11 fullscreens
		if DisplayServer.window_get_mode() == 0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	if event.is_action_pressed("closegame"): # esc closes game
		get_tree().quit()
