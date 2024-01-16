extends CharacterBody2D
@onready var player = $"../Player"
var speed = 50
var hp = 4

#DEBUG
@onready var debug_hp_label = $hp

func _physics_process(delta):
	position = position.move_toward(player.position, delta * speed) #constantly move toward the player
	
	#somehow makes them collide with eachother without everything breaking
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	
	if hp == 0:
		print("enemy01 killed")
		queue_free()
	
	#DEBUG
	debug_hp_label.text = str(hp)
	if Input.is_action_just_pressed("DEBUG-hp-1"):
		hp -= 1
