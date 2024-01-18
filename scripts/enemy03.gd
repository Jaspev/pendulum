extends CharacterBody2D
@onready var player = $"../Player"
@onready var enemy_iframes = $enemy_iframes
@onready var shoot_sfx = $shoot_sfx
@onready var bullet = preload("res://scenes/bullet.tscn")
@onready var shoot_timer = Timer.new()

var speed = 15
var hp = 2
var points = 15

func _ready():
	shoot_timer.wait_time = 1.0
	shoot_timer.autostart = true
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)
	add_child(shoot_timer)

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

func _on_shoot_timer_timeout():
	shoot_sfx.play()
	var bullet_instanced = bullet.instantiate()
	bullet_instanced.position = position
	bullet_instanced.rotation = get_angle_to(player.position)
	get_parent().add_child(bullet_instanced)
