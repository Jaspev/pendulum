extends Area2D

@onready var player = $"../Player"
@onready var timer = Timer.new()

var speed = 150

func _ready():
	timer.wait_time = 2.5
	timer.autostart = true
	timer.timeout.connect(_on_kill_timer_timeout)
	add_child(timer)

func _process(delta):
	position += transform.x * speed * delta

func _on_kill_timer_timeout():
	queue_free()
