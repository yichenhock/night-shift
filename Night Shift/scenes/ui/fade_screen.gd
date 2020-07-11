extends ColorRect
export(float) var fade_in_time = 1 
export(float) var fade_out_time = 1
signal fade_in_finished
signal fade_out_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	fade_in()

func fade_out(): 
	if fade_out_time ==0: 
		visible = true
		emit_signal("fade_out_finished")
		return
	$fadeAnimation.playback_speed = 1/fade_out_time
	$fadeAnimation.play("fadeOut")
	yield($fadeAnimation,"animation_finished")
	emit_signal("fade_out_finished")
	
func fade_in(): 
	if fade_in_time ==0: 
		visible = false
		emit_signal("fade_in_finished")
		return
	$fadeAnimation.playback_speed = 1/fade_in_time
	$fadeAnimation.play("fadeIn")
	yield($fadeAnimation,"animation_finished")
	emit_signal("fade_in_finished")
