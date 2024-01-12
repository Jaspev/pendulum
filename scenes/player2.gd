extends RigidBody2D
@onready var viewport_size = get_viewport_rect().size

var hit_force : float = 7.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var dir = global_position.direction_to(get_global_mouse_position())
		apply_impulse(dir * hit_force)

	if position.x >= viewport_size.x:
		position.x = viewport_size.x
	if position.x <= 0:
		position.x = 1
	if position.x >= 320:
		position.x = 319
	if position.y >= viewport_size.y:
		position.y = viewport_size.y
	if position.y <= 0:
		position.y = 1
	if position.y >= 180:
		position.y = 179