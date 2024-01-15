extends CenterContainer

@onready var check_box = $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/CheckBox

func _input(_event):
	#make sure if window is fullscreen, update fullscreen checkbox
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		check_box.button_pressed = true
	else:
		check_box.button_pressed = false

func _on_button_start_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_button_quit_pressed():
	get_tree().quit()

func _on_check_box_pressed():
	if check_box.button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
