extends Control
signal radio_pressed()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_radio_pressed():
	emit_signal("radio_pressed")
