extends Node2D
@onready var timer = Timer.new()
@onready var rng = RandomNumberGenerator.new()
@onready var viewport_size = get_viewport_rect().size

#enemies
@onready var enemy01 = preload("res://scenes/enemy01.tscn")
@onready var enemy02_01 = preload("res://scenes/enemy02_01.tscn")
@onready var enemy03 = preload("res://scenes/enemy03.tscn")

@onready var plrhpui = $PlayerHPUI
@onready var scoreui = $score
@onready var moneyui = $money

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	timer.wait_time = 3
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _process(delta):
	plrhpui.size.y = GLOBAL.plr_hp * 14 # 14 being the size of the texture, and texturerect tiles when scaled
	if GLOBAL.plr_hp <= 0:
		get_tree().change_scene_to_file("res://scenes/death.tscn")
	
	scoreui.text = str("SCORE: ", GLOBAL.score)
	moneyui.text = str("MONEY: ", GLOBAL.money)

func _on_timer_timeout():
	var instanced_enemy01 = enemy01.instantiate()
	var instanced_enemy02_01 = enemy02_01.instantiate()
	var instanced_enemy03 = enemy03.instantiate()
	var coin
	var pos_x
	var pos_y
	
	# Randomly choose enemy spawn position. Probably a way better way to do this but this works.
	randomize() # I don't think i need to call randomize this much but i'm too lazy to test if I do or don't
	coin = rng.randf_range(-1,1)
	if coin >= 0: #IF POSITIVE, SET ENEMY POS ON EITHER LEFT OF RIGHT
		randomize()
		coin = rng.randf_range(-1,1)
		if coin >= 0: #IF POSITIVE, SET ENEMY POS ON LEFT
			randomize()
			pos_x = rng.randf_range(-50,-10)
			randomize()
			pos_y = rng.randf_range(-50,viewport_size.y+50)
		else: #IF NEGATIVE, SET ENEMY POS ON RIGHT
			randomize()
			pos_x = rng.randf_range(viewport_size.x+10,viewport_size.x+50)
			randomize()
			pos_y = rng.randf_range(-50,viewport_size.y+50)
	else: #IF NEGATIVE, SET ENEMY POS ON EITHER TOP OR BOTTOM
		randomize()
		coin = rng.randf_range(-1,1)
		if coin >= 0: #IF POSITIVE, SET ENEMY POS ON TOP
			randomize()
			pos_x = rng.randf_range(-50,viewport_size.x+50)
			randomize()
			pos_y = rng.randf_range(-50,-10)
		else: #IF NEGATIVE, SET ENEMY POS ON BOTTOM
			randomize()
			pos_x = rng.randf_range(-50,viewport_size.x+50)
			randomize()
			pos_y = rng.randf_range(viewport_size.y+10,viewport_size.y+50)
	
	var rand_pos = Vector2(pos_x,pos_y)
	
	# put instanced enemies into an array so they can randomly be selected from array
	var enemies_array = [instanced_enemy01, instanced_enemy02_01, instanced_enemy03] #full list
	#var enemies_array = [instanced_enemy03] # for testing
	var rand_selected_enemy = enemies_array[randi() % enemies_array.size()]
	rand_selected_enemy.position = rand_pos
	add_child(rand_selected_enemy)
