extends CharacterBody2D
@onready var player = $"../Player"
@onready var enemy02_02 = preload("res://scenes/enemy02_02.tscn")
@onready var parent_node = get_parent()
var speed = 25
var hp = 6

#DEBUG
@onready var debug_hp_label = $hp
	
func _physics_process(delta):
	position = position.move_toward(player.position, delta * speed) #constantly move toward the player
	
	#somehow makes them collide with eachother without everything breaking
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	
	if hp == 0: #if killed, spawn 2 enemy02_02's
		print("enemy02_01 killed")
		var instanced_enemy02_02 = enemy02_02.instantiate()
		instanced_enemy02_02.position.y = position.y
		instanced_enemy02_02.position.x = position.x + 1
		parent_node.add_child(instanced_enemy02_02)
		instanced_enemy02_02.position.x = position.x - 1
		parent_node.add_child(instanced_enemy02_02)
		queue_free()
	
	#DEBUG
	debug_hp_label.text = str(hp)
	if Input.is_action_just_pressed("hp-1"):
		hp -= 1
