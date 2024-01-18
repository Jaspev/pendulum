extends Sprite2D

@onready var player = $"../Player"
@onready var flail = $"../flailballsmall"

func _process(delta):
	rotation = 0 # fix rotation to not have funny aliasing stuff with sprites
	
	# prob a way to simplify this but whatever lmao
	position = ((flail.position - player.position)/2) + player.position
