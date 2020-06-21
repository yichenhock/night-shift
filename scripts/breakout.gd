extends Node2D

func _input(event):
	if event.is_action_pressed("ui_accept"):
		$paddle.set_physics_process(true)
		$CanvasLayer/start.visible = false
		$spikes.visible = true
		$ball.sleeping = false
