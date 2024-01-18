extends CharacterBody2D
@onready var player = $"../Player"
@onready var enemy02_03 = preload("res://scenes/enemy02_03.tscn")
@onready var enemy_iframes = $enemy_iframes
@onready var rng = RandomNumberGenerator.new()
@onready var coin_preload = preload("res://scenes/coin.tscn")

var speed = 50
var hp = 4
var points = 5

func _ready():
	enemy_iframes.start()

func _physics_process(delta):
	position = position.move_toward(player.position, delta * speed) #constantly move toward the player
	
	#somehow makes them collide with eachother without everything breaking
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	
	if hp <= 0: #if killed, spawn 2 enemy02_03's
		GLOBAL.score += points
		GLOBAL.kill_count += 1
		
		var coinflip = rng.randf_range(-1,1)
		if coinflip >= 0:
			var coin_inst = coin_preload.instantiate()
			coin_inst.position = position
			get_parent().add_child(coin_inst)
		
		var instanced_enemy02_03_01 = enemy02_03.instantiate()
		var instanced_enemy02_03_02 = enemy02_03.instantiate()
		# offsetting one instances position so they don't get stuck in eachother
		instanced_enemy02_03_01.position = position + Vector2(1,1)
		get_parent().add_child(instanced_enemy02_03_01)
		instanced_enemy02_03_02.position = position
		get_parent().add_child(instanced_enemy02_03_02)
		queue_free()
