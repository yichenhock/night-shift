extends Control
signal change_state(new_state)

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("showText")
	yield($AnimationPlayer,"animation_finished")
	emit_signal("change_state","houseGame1")
