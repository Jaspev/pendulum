extends Node2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	GLOBAL.reset()

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/title.tscn")
