extends RigidBody2D

@onready var collision = $"../flailballbigArea2D/flailballbigrealcollision"

func _process(delta):
	rotation = 0 # fix rotation to not have funny aliasing stuff with sprites
	collision.position = position # lock area2D collision to flail
