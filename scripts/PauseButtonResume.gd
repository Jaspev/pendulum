extends Button

@onready var pauseui = $"../../.."

func _on_pressed():
	pauseui.pause_close()
