extends Area2D
@onready var viewport_size = get_viewport_rect().size

func _ready():
	pass
	
func _process(delta):
	var cursor_pos = get_viewport().get_mouse_position()
	position = cursor_pos
	
	# player position cannot be more than viewport bounds
	if position.x >= viewport_size.x:
		position.x = viewport_size.x
	if position.x <= 0:
		position.x = 0
	if position.y >= viewport_size.y:
		position.y = viewport_size.y
	if position.y <= 0:
		position.y = 0
