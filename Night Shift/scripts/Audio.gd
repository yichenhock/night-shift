extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	for node in $radio.get_children(): 
		if node.get_class() == "AudioStreamPlayer": 
			node.bus = "Radio"

func play(sound):
	get_node(sound).play()
	
func play_radio(sound):
	$radio.get_node(sound).play()
	
func stop(sound): 
	get_node(sound).stop()
	
func pause(sound): 
	get_node(sound).stream_paused = true
	
func unpause(sound): 
	get_node(sound).stream_paused = false
	
func stop_all(): 
	for node in get_children(): 
		if node.get_class() == "AudioStreamPlayer":
			node.stop()

func stop_radio(): 
	for node in $radio.get_children(): 
		if node.get_class() == "AudioStreamPlayer":
			node.stop()

func fade_out(duration): 
	pass
