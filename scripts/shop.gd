extends CenterContainer

@onready var check_box = $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/CheckBox
@onready var hoversfx = $"../hoversfx"

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
func _input(_event):
	if _event.is_action_pressed("DEBUG1"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
