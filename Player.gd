extends Area2D
@onready var player=$"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print( get_viewport().get_mouse_position() )
	player.position.x = get_viewport().get_mouse_position().x
	player.position.y = get_viewport().get_mouse_position().y
