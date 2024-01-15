extends RigidBody2D

#fix rotation to not have funny aliasing stuff with sprites

func _process(delta):
	rotation = 0
