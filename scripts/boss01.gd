extends CharacterBody2D
@onready var player = $"../Player"
@onready var enemy_iframes = $enemy_iframes
@onready var shoot_sfx = $shoot_sfx
@onready var shoot_timer = Timer.new()
@onready var gun = Node2D.new()
@onready var rng = RandomNumberGenerator.new()
@onready var bullet = preload("res://scenes/bullet.tscn")
@onready var coin_preload = preload("res://scenes/coin.tscn")

var speed = 15
var hp = 20
var points = 100

var gun_rot_speed = rad_to_deg(1) # 30 degrees per second

func _ready():
	shoot_timer.wait_time = 0.1
	shoot_timer.autostart = true
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)
	add_child(shoot_timer)
	add_child(gun)

func _physics_process(delta):
	gun.rotation = gun.rotation + gun_rot_speed * delta
	
	position = position.move_toward(player.position, delta * speed) #constantly move toward the player
	
	#somehow makes them collide with eachother without everything breaking
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	
	if hp <= 0:
		GLOBAL.score += points
		GLOBAL.kill_count += 1
		GLOBAL.bosses_killed += 1
		var coinflip = rng.randf_range(-1,1)
		if coinflip >= 0:
			var coin_inst = coin_preload.instantiate()
			coin_inst.position = position
			get_parent().add_child(coin_inst)
		queue_free()

func _on_shoot_timer_timeout():
	shoot_sfx.play()
	var bullet_instanced = bullet.instantiate()
	bullet_instanced.position = position
	bullet_instanced.rotation = gun.rotation
	get_parent().add_child(bullet_instanced)
