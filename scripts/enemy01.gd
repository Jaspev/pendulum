extends CharacterBody2D
@onready var player = $"../Player"
@onready var enemy_iframes = $enemy_iframes
@onready var hit = $hit
@onready var rng = RandomNumberGenerator.new()
@onready var coin_preload = preload("res://scenes/coin.tscn")

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
		var coinflip = rng.randf_range(-1,1)
		if coinflip >= 0:
			var coin_inst = coin_preload.instantiate()
			coin_inst.position = position
			get_parent().add_child(coin_inst)
		queue_free()
