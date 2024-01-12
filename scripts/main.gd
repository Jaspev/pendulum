extends Node2D
@onready var timer = Timer.new()
@onready var rng = RandomNumberGenerator.new()
@onready var enemy01 = preload("res://scenes/enemy01.tscn")
@onready var viewport_size = get_viewport_rect().size

func _ready():
	timer.wait_time = 5.0
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	
func _on_timer_timeout():
	var instanced_enemy01 = enemy01.instantiate()
	
	randomize()
	var pos_x = rng.randf_range(-50,viewport_size.x+50)
	randomize()
	var pos_y = rng.randf_range(-50,viewport_size.y+50)
	var rand_pos = Vector2(pos_x,pos_y)
	
	instanced_enemy01.position = rand_pos
	
	print("enemy01 spawned")
	add_child(instanced_enemy01)
