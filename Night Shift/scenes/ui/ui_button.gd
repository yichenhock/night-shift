extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_ui_button_mouse_entered():
	$AnimationPlayer.play("mouse_enter")

func _on_ui_button_mouse_exited():
	$AnimationPlayer.play("mouse_exit")
