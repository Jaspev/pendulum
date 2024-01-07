extends CharacterBody2D
@onready var player = $"../Player"
var speed = 50

func _ready():
	pass 
	
func _physics_process(delta):
	#constantly move toward the player
	position = position.move_toward(player.position, delta * speed)
	
	#somehow makes them collide with eachother without everything breaking
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
