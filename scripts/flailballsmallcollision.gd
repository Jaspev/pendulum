extends Area2D

@onready var sfx_hit_enemy = $"../hit_enemy_small"

var damage = 1

func _on_body_entered(body):
	var coll_bodi = get_overlapping_bodies()

	for n in coll_bodi:
		if n.is_in_group("enemy") and n.enemy_iframes.is_stopped():
			n.hp -= damage
			sfx_hit_enemy.play()
