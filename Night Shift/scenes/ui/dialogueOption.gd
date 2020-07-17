tool
extends TextureButton
var text = "" setget set_text

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_text(new_text): 
	text = new_text
	$HBox/text.text = text

func _on_dialogueOption_focus_entered():
	$HBox/indicator.visible = true
	$HBox.rect_position.x = 8
	rect_min_size.x +=12

func _on_dialogueOption_focus_exited():
	$HBox/indicator.visible = false
	$HBox.rect_position.x = 0
	rect_min_size.x -=12


func _on_dialogueOption_mouse_entered():
	grab_focus()
