extends Node2D

@onready var death_sfx = $sfx_death
@onready var scoreui = $CenterContainer/VBoxContainer/score
@onready var killcountui = $CenterContainer/VBoxContainer/killcount
@onready var moneyui = $CenterContainer/VBoxContainer/moneyleft

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	death_sfx.play()
	scoreui.text = str("your score was: ", GLOBAL.score)
	moneyui.text = str("you died with ", GLOBAL.money, " pennies in your pocket")
	killcountui.text = str("you killed ", GLOBAL.kill_count, " enemies")

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	GLOBAL.reset()

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/title.tscn")
