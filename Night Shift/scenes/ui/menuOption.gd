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
	if not disabled:
		$HBox/option.add_font_override("font",load("res://assets/fonts/dynamic_fonts/Typecast-Italic.tres"))
#	$HBox/indicator.visible = true

func _on_menuOption_focus_exited():
	$HBox/option.add_font_override("font",load("res://assets/fonts/dynamic_fonts/Typecast.tres"))
#	$HBox/indicator.visible = false
	Audio.play("menuClickSFX")

func _on_menuOption_mouse_entered():
	grab_focus()

func _on_menuOption_mouse_exited():
	release_focus()
