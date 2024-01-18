extends CharacterBody2D
@onready var player = $"../Player"
@onready var enemy_iframes = $enemy_iframes
@onready var hit = $hit

var speed = 50
var hp = 4
var points = 10

func _physics_process(delta):
	position = position.move_toward(player.position, delta * speed) #constantly move toward the player
	
	#somehow makes them collide with eachother without everything breaking
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	
	if hp <= 0:
		GLOBAL.score += points
		GLOBAL.kill_count += 1
		queue_free()
