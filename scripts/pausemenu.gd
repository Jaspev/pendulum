extends Control

func pause_open():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	visible = true
	get_tree().paused = true

func pause_close():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	visible = false
	get_tree().paused = false
