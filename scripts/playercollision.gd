extends Area2D

@onready var iframes_timer = $"../Player/iframestimer"
@onready var iframes_anim = $"../Player/iframesanim"

func hurt_player():
	print("player hit")
	GLOBAL.plr_hp -= 1
	iframes_timer.start()
	iframes_anim.queue("iframes_anim")

func _process(delta):
	var coll_bodi = get_overlapping_bodies()
	var coll_area = get_overlapping_areas()
	
	for n in coll_bodi:
		if  n.is_in_group("enemy") and iframes_timer.is_stopped():
			hurt_player()
			
	for n in coll_area:
		if  n.is_in_group("enemy") and iframes_timer.is_stopped():
			hurt_player()
