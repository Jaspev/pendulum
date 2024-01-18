extends CharacterBody2D
@onready var player = $"../Player"
@onready var enemy_iframes = $enemy_iframes

var speed = 75
var hp = 2
var points = 2

func _ready():
	enemy_iframes.start()

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
