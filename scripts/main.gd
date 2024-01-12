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
	var coin
	var pos_x
	var pos_y
	
	randomize() #LIFE IS PAIN i don't think i need to call randomize this much but there's no harm it it... probably
	coin = rng.randf_range(-1,1)
	if coin >= 0: #IF POSITIVE, SPAWN ENEMY ON EITHER LEFT OF RIGHT
		randomize()
		coin = rng.randf_range(-1,1)
		if coin >= 0: #IF POSITIVE, SPAWN ENEMY ON LEFT
			randomize()
			pos_x = rng.randf_range(-50,-10)
			randomize()
			pos_y = rng.randf_range(-50,viewport_size.y+50)
		else: #IF NEGATIVE, SPAWN ENEMY ON RIGHT
			randomize()
			pos_x = rng.randf_range(viewport_size.x+10,viewport_size.x+50)
			randomize()
			pos_y = rng.randf_range(-50,viewport_size.y+50)
	else: #IF NEGATIVE, SPAWN ENEMY ON EITHER TOP OR BOTTOM
		randomize()
		coin = rng.randf_range(-1,1)
		if coin >= 0: #IF POSITIVE, SPAWN ENEMY ON TOP
			randomize()
			pos_x = rng.randf_range(-50,viewport_size.x+50)
			randomize()
			pos_y = rng.randf_range(-50,-10)
		else: #IF NEGATIVE, SPAWN ENEMY ON BOTTOM
			randomize()
			pos_x = rng.randf_range(-50,viewport_size.x+50)
			randomize()
			pos_y = rng.randf_range(viewport_size.y+10,viewport_size.y+50)
	
	var rand_pos = Vector2(pos_x,pos_y)
	
	instanced_enemy01.position = rand_pos
	
	print("enemy01 spawned @ ", rand_pos)
	add_child(instanced_enemy01)
