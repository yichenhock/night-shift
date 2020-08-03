tool
extends TextureButton
export(String) var option_text = "" setget set_text

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func set_text(new_text): 
	option_text = new_text
	
	$optionText.text = option_text

func _on_dialogueOption_focus_entered():
	$NinePatchRect.modulate = Color("e6243133")

func _on_dialogueOption_focus_exited():
	$NinePatchRect.modulate = Color("243133")

func _on_dialogueOption_mouse_entered():
	grab_focus()

func _on_dialogueOption_mouse_exited():
	release_focus()
