extends HBoxContainer

@onready var check_box = $rightcolumn/fullscreen/CheckBox

func _on_button_start_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_button_quit_pressed():
	get_tree().quit()

func _on_check_box_pressed():
	if check_box.button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
