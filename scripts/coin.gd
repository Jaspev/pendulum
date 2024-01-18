extends Area2D

@onready var player = $"../Player"

var speed = 10

func _process(delta):
	position = position.move_toward(player.position, delta * speed) #constantly move toward the player
