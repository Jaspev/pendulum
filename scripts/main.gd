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
@onready var boss02 = preload("res://scenes/boss02.tscn")
@onready var boss03 = preload("res://scenes/boss03.tscn")

#ui
@onready var plrhpui = $PlayerHPUI
@onready var scoreui = $score
@onready var moneyui = $money

var current_enemies

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	timer.wait_time = 2.5
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _process(delta):
	current_enemies = get_tree().get_nodes_in_group("current_enemies").size()
	
	plrhpui.size.y = GLOBAL.plr_hp * 14 # 14 being the size of the texture, and texturerect tiles when scaled
	if GLOBAL.plr_hp <= 0:
		get_tree().change_scene_to_file("res://scenes/death.tscn")
	
	scoreui.text = str("SCORE: ", GLOBAL.score)
	moneyui.text = str("MONEY: ", GLOBAL.money)

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
	var instanced_boss02 = boss02.instantiate()
	var instanced_boss03 = boss03.instantiate()
	
	var enemies_array:Array # enemies_array decides what enemies can spawn every time the timer ends
	var count_for_first_boss = 5 # how many enemies to kill for first boss to spawn
	var count_for_second_boss = 10 + 1
	var count_for_third_boss = 15 + 2
	var count_for_all_boss = 20 + 3
	if GLOBAL.enemy_spawn_count < count_for_first_boss:
		enemies_array = [instanced_enemy01]
	elif GLOBAL.enemy_spawn_count == count_for_first_boss and current_enemies == 0:
		enemies_array = [instanced_boss01]
	elif GLOBAL.enemy_spawn_count >= count_for_first_boss+1 and GLOBAL.enemy_spawn_count < count_for_second_boss and GLOBAL.bosses_killed == 1:
		enemies_array = [instanced_enemy01, instanced_enemy02_01]
	elif GLOBAL.enemy_spawn_count == count_for_second_boss and current_enemies == 0:
		enemies_array = [instanced_boss02]
	elif GLOBAL.enemy_spawn_count >= count_for_second_boss+1 and GLOBAL.enemy_spawn_count < count_for_third_boss and GLOBAL.bosses_killed == 2:
		enemies_array = [instanced_enemy01, instanced_enemy02_01, instanced_enemy03]
	elif GLOBAL.enemy_spawn_count == count_for_third_boss and current_enemies == 0:
		enemies_array = [instanced_boss03]
	# the loop point
	elif  GLOBAL.enemy_spawn_count >= count_for_third_boss+1 and GLOBAL.enemy_spawn_count < count_for_all_boss and GLOBAL.bosses_killed == 3:
		enemies_array = [instanced_enemy01, instanced_enemy02_01, instanced_enemy03]
	elif GLOBAL.enemy_spawn_count == count_for_all_boss and current_enemies == 0:
		enemies_array = [instanced_boss01, instanced_boss02, instanced_boss03]
	elif GLOBAL.bosses_killed == 4:
		# basically just need to reset variables to wherever we want to loop the game infinitely
		GLOBAL.enemy_spawn_count = count_for_third_boss+1
		GLOBAL.bosses_killed = 3
	
	if enemies_array.size() > 0:
		var rand_selected_enemy
		rand_selected_enemy = enemies_array[randi() % enemies_array.size()]
		
		# Randomly choose enemy spawn position within margin outside of screen.
		var margin_min = 20
		var margin_max = 75
		var pos_x = rng.randi_range(-margin_max, viewport_size.x + margin_max)
		var pos_y = rng.randi_range(-margin_max, viewport_size.y + margin_max)
		# make sure pos is not within the screen, if either are: reroll both
		while pos_x >= -margin_min and pos_x <= viewport_size.x+margin_min and pos_y >= -margin_min and pos_y <= viewport_size.y+margin_min:
			pos_x = rng.randi_range(-margin_max, viewport_size.x + margin_max)
			pos_y = rng.randi_range(-margin_max, viewport_size.y + margin_max)
		rand_selected_enemy.position = Vector2(pos_x,pos_y) #set enemy position
		rand_selected_enemy.add_to_group("current_enemies")
		add_child(rand_selected_enemy) # spawn enemy into world as child of main scene
		GLOBAL.enemy_spawn_count += 1
