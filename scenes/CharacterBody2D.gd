extends CharacterBody2D
@onready var viewport_size = get_viewport_rect().size

func _ready():
	pass
	
func _process(delta):
	var cursor_pos_x = snapped(get_viewport().get_mouse_position().x, 1) - 0.5 # snapped to round to whole number,
	var cursor_pos_y = snapped(get_viewport().get_mouse_position().y, 1) - 0.5 # and -0.5 to fix visual bug.
	var cursor_pos_snapped = Vector2(cursor_pos_x, cursor_pos_y)
	position = cursor_pos_snapped
	
	# player position cannot be more than viewport bounds
	if position.x >= viewport_size.x:
		position.x = viewport_size.x
	if position.x <= 0:
		position.x = 0
	if position.y >= viewport_size.y:
		position.y = viewport_size.y
	if position.y <= 0:
		position.y = 0
