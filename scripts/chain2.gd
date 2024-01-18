extends Sprite2D

@onready var flail1 = $"../flailballsmall"
@onready var flail2 = $"../flailballbig"

func _process(delta):
	rotation = 0 # fix rotation to not have funny aliasing stuff with sprites
	
	# prob a way to simplify this but whatever lmao
	position = ((flail1.position - flail2.position)/2) + flail2.position
