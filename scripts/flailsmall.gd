extends RigidBody2D

@onready var collision = $"../flailballsmallArea2D/flailballsmallrealcollision"

func _process(delta):
	rotation = 0 # fix rotation to not have funny aliasing stuff with sprites
	collision.position = position # lock area2D collision to flail
