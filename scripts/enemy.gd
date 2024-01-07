extends Area2D
@onready var player = $"../Player"
var speed = 75

func _ready():
	pass 
	
func _process(delta):
	print(self.position)
	position = position.move_toward(player.position, delta * speed)
