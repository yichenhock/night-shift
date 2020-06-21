tool
extends TextureButton
export(String) var option_text = "" setget set_text

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_text(new_text): 
	option_text = new_text
	$HBox/option.text = option_text

func _on_menuOption_focus_entered():
	$HBox/indicator.visible = true

func _on_menuOption_focus_exited():
	$HBox/indicator.visible = false
	Audio.play("menuClickSFX")

func _on_menuOption_mouse_entered():
	grab_focus()
