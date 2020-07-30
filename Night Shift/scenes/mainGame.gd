extends Node
#signal fully_faded
var current_scene = null

func _ready():
#	OS.window_fullscreen = true
	change_state("mainMenu")
	var volume = Data.get_data("volume",1) #from 0 to 1
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(volume))
	
func change_state(new_scene_name):
	remove_child(current_scene)
	current_scene = $Scenes.get_resource(new_scene_name).instance()
	add_child(current_scene)
	current_scene.connect("change_state",self,"change_state")

func _unhandled_input(event):
	if event.is_action_pressed("fullscreen_toggle"): 
		OS.window_fullscreen = !OS.window_fullscreen
