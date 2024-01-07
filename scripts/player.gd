extends Area2D

func _ready():
	pass
	
func _process(delta):
	position.x = get_viewport().get_mouse_position().x
	position.y = get_viewport().get_mouse_position().y
