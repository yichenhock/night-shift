tool
extends TextureButton
export(String) var option_text = "" setget set_text

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	$AnimationPlayer.play_backwards("hover")
	
func set_text(new_text): 
	option_text = new_text
	$optionText.text = option_text

func _on_dialogueOption_focus_entered():
	$AnimationPlayer.play("hover")

func _on_dialogueOption_focus_exited():
	$AnimationPlayer.play_backwards("hover")

func fade_in(): 
	$AnimationPlayer.play("fadeIn")
	
func fade_out(): 
	$AnimationPlayer.play("fadeOut")

func _on_dialogueOption_mouse_entered():
	grab_focus()


func _on_dialogueOption_mouse_exited():
	release_focus()
