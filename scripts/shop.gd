extends Node2D

@onready var check_box = $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/CheckBox
@onready var hoversfx = $"../hoversfx"
@onready var moneyui = $money

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(_event):
	if _event.is_action_pressed("shop"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
		
func _on_button_penis_pressed():
	if GLOBAL.money >= 10:
		GLOBAL.money -= 10
	if GLOBAL.money <= 0:
		GLOBAL.money = 0
		
func _on_button_penis_mouse_entered():
	hoversfx.play()
