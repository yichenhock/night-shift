extends Control
signal finished()
export var delay = 0.1 setget set_delay

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_speech(text): 
	$dialogue.type_text(text)

func set_delay(new_delay): 
	delay = new_delay
	$dialogue.delay = delay
