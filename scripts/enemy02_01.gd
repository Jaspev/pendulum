extends CharacterBody2D
@onready var player = $"../Player"
@onready var enemy02_02 = preload("res://scenes/enemy02_02.tscn")
@onready var enemy_iframes = $enemy_iframes

var speed = 25
var hp = 6
var points = 20
	
func _physics_process(delta):
	position = position.move_toward(player.position, delta * speed) #constantly move toward the player
	
	#somehow makes them collide with eachother without everything breaking
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	
	if hp <= 0: #if killed, spawn 2 enemy02_02's
		GLOBAL.score += points
		GLOBAL.kill_count += 1
		var instanced_enemy02_02_01 = enemy02_02.instantiate()
		var instanced_enemy02_02_02 = enemy02_02.instantiate()
		# offsetting one instances position so they don't get stuck in eachother
		instanced_enemy02_02_01.position = position + Vector2(1,1)
		get_parent().add_child(instanced_enemy02_02_01)
		instanced_enemy02_02_02.position = position
		get_parent().add_child(instanced_enemy02_02_02)
		queue_free()
