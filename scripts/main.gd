extends Node2D
@onready var timer = Timer.new()
@onready var rng = RandomNumberGenerator.new()
@onready var viewport_size = get_viewport_rect().size

#enemies
@onready var enemy01 = preload("res://scenes/enemy01.tscn")
@onready var enemy02_01 = preload("res://scenes/enemy02_01.tscn")
@onready var enemy03 = preload("res://scenes/enemy03.tscn")

#bosses
@onready var boss01 = preload("res://scenes/boss01.tscn")

#ui
@onready var plrhpui = $PlayerHPUI
@onready var scoreui = $score
@onready var moneyui = $money

#DEBUG
@onready var DEBUGspawncountui = $DEBUGkillcount

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	timer.wait_time = 2.5
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _process(delta):
	plrhpui.size.y = GLOBAL.plr_hp * 14 # 14 being the size of the texture, and texturerect tiles when scaled
	if GLOBAL.plr_hp <= 0:
		get_tree().change_scene_to_file("res://scenes/death.tscn")
	
	scoreui.text = str("SCORE: ", GLOBAL.score)
	moneyui.text = str("MONEY: ", GLOBAL.money)
	
	#DEBUG
	DEBUGspawncountui.text = str("DEBUG SPAWNCOUNT: ", GLOBAL.enemy_spawn_count)

func _input(event):
	if event.is_action_pressed("menu"): # esc opens menu
		get_tree().change_scene_to_file("res://scenes/title.tscn")
		
	if event.is_action_pressed("shop"): # tab opens shop
		get_tree().change_scene_to_file("res://scenes/shop.tscn")
	
	# DEBUG put whatever you wanna debug here whenever you press "D"
	if event.is_action_pressed("DEBUG1"):
		pass
	# DEBUG put whatever you wanna debug here whenever you press "F"
	if event.is_action_pressed("DEBUG2"):
		pass
func _on_timer_timeout():
	var instanced_enemy01 = enemy01.instantiate()
	var instanced_enemy02_01 = enemy02_01.instantiate()
	var instanced_enemy03 = enemy03.instantiate()
	var instanced_boss01 = boss01.instantiate()
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
	# enemy list: instanced_enemy01, instanced_enemy02_01, instanced_enemy03
	# boss list: instanced_boss01
	var enemies_array = []
	if GLOBAL.enemy_spawn_count <= 25:
		enemies_array = [instanced_enemy01, instanced_enemy02_01, instanced_enemy03] #full list
	elif GLOBAL.enemy_spawn_count >= 25: # if spawn count >= 25 and no enemies are on screen
		enemies_array = [instanced_boss01]
	var rand_selected_enemy = enemies_array[randi() % enemies_array.size()]
	rand_selected_enemy.position = rand_pos
	add_child(rand_selected_enemy)
	GLOBAL.enemy_spawn_count += 1
