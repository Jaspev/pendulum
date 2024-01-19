extends Node2D

@onready var death_sfx = $sfx_death
@onready var hover_sfx = $hoversfx

@onready var scoreui = $CenterContainer/VBoxContainer/score
@onready var killcountui = $CenterContainer/VBoxContainer/killcount
@onready var moneyui = $CenterContainer/VBoxContainer/moneyleft
@onready var unique = $CenterContainer/VBoxContainer/uniquemessage

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	death_sfx.play()
	scoreui.text = str("your score was: ", GLOBAL.score)
	moneyui.text = str("you died with ", GLOBAL.money, " pennies in your pocket")
	killcountui.text = str("you killed ", GLOBAL.kill_count, " enemies")
	
	# unique message changes depending on what score you got
	if GLOBAL.score < 0:
		unique.text = str("you managed to get an impossibly low score")
	elif GLOBAL.score <= 0:
		unique.text = str("i didn't know it was possible to be that bad...")
	elif GLOBAL.score == 69:
		unique.text = str("nice...")
	elif GLOBAL.score == 420:
		unique.text = str("funny number hahahahahahahhahhahahahahha")
	elif GLOBAL.score >= 1 and GLOBAL.score <= 299:
		unique.text = str("you are horrible at the game...")
	elif GLOBAL.score >= 300 and GLOBAL.score <= 999:
		unique.text = str("decent...")
	elif GLOBAL.score >= 1000:
		unique.text = str("better...")
	else:
		unique.text = str("something went horribly wrong...")
	

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	GLOBAL.reset()

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/title.tscn")

func _on_retry_mouse_entered():
	hover_sfx.play()

func _on_menu_mouse_entered():
	hover_sfx.play()
