extends CharacterBody2D
@onready var player = $"../Player"
@onready var bullet = preload("res://scenes/bullet.tscn")
@onready var enemy_iframes = $enemy_iframes
@onready var shoot_timer = Timer.new()
var speed = 15
var hp = 2

#DEBUG
@onready var debug_hp_label = $hp

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
		queue_free()
	
	#DEBUG
	debug_hp_label.text = str(hp)
	if Input.is_action_just_pressed("DEBUG-hp-1"):
		hp -= 1

func _on_shoot_timer_timeout():
	var bullet_instanced = bullet.instantiate()
	bullet_instanced.position = position
	bullet_instanced.rotation = get_angle_to(player.position)
	get_parent().add_child(bullet_instanced)
