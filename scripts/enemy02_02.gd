extends CharacterBody2D
@onready var player = $"../Player"
@onready var enemy02_03 = preload("res://scenes/enemy02_03.tscn")
@onready var enemy_iframes = $enemy_iframes
var speed = 50
var hp = 4

#DEBUG
@onready var debug_hp_label = $hp

func _ready():
	enemy_iframes.start()

func _physics_process(delta):
	position = position.move_toward(player.position, delta * speed) #constantly move toward the player
	
	#somehow makes them collide with eachother without everything breaking
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	
	if hp <= 0: #if killed, spawn 2 enemy02_03's
		var instanced_enemy02_03_01 = enemy02_03.instantiate()
		var instanced_enemy02_03_02 = enemy02_03.instantiate()
		# offsetting one instances position so they don't get stuck in eachother
		instanced_enemy02_03_01.position = position + Vector2(1,1)
		get_parent().add_child(instanced_enemy02_03_01)
		instanced_enemy02_03_02.position = position
		get_parent().add_child(instanced_enemy02_03_02)
		queue_free()
	
	#DEBUG
	debug_hp_label.text = str(hp)
	if Input.is_action_just_pressed("DEBUG-hp-1"):
		hp -= 1
