tool
extends Label
export(String) var choice_text = "" setget set_text

func set_text(new_text): 
	choice_text = new_text
	text = choice_text
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
