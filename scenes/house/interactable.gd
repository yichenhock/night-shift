extends Area2D
signal interacted()
signal player_exited()
signal player_entered()
export(String) var audio
var player_inside = false
export(bool) var hide_on_interact = false
export(bool) var active = true setget set_active

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_interactable_body_entered(body):
	if body is Player: 
		player_inside = true
		$showHide.play("show")
		emit_signal("player_entered")

func _on_interactable_body_exited(body):
	if body is Player: 
		player_inside = false
		$showHide.play("hide")
		emit_signal("player_exited")
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		if player_inside:
			get_tree().set_input_as_handled()
			if audio != "":
				Audio.play(audio)
			emit_signal("interacted")
			if hide_on_interact: 
				player_inside = false
				$showHide.play("hide")

func set_active(state): 
	active = state
	visible = active
	monitoring = active
