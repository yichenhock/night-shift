extends Node2D
enum Direction {LEFT, RIGHT, NULL = -1}

var current_scene = null

func _ready():
	change_environment("shopFront")
	
func change_environment(new_scene_name):
	
	# - Yeeting old scene
	
	# Get name of the current scene. ".name" just gets the name of the node. 
	var old_scene_name = null
	if current_scene != null:
		old_scene_name = current_scene.name
	# Now yeet it
	remove_child(current_scene)
	
	# - Adding new scene
	
	# Get the new scene from the ResourcePreloader node
	# look up "godot resourcepreloader" to understand this one
	current_scene = $Scenes.get_resource(new_scene_name).instance()
	# Add this new one to replace the old one
	add_child(current_scene)
	
	current_scene.connect("changed_environment",self,"change_environment")
	
	# Move the child in the node tree to the top so its being drawn first!
	move_child(current_scene,0)
	
	# - Setting player position
	var spawn_node_name = "startPos"
	if old_scene_name != null: # Coming from another environment 
		spawn_node_name = old_scene_name + "Pos"
	if not current_scene.has_node(spawn_node_name):
		print("No spawn node of name "+ spawn_node_name)
	$Player.position = current_scene.get_node(spawn_node_name).position
	
	if "facing" in current_scene.get_node(spawn_node_name):
		var facing = current_scene.get_node(spawn_node_name).facing
		if facing != Direction.NULL:
			$Player.set_facing(facing)

func block_player(): 
	$Player.block()
	
func unblock_player(): 
	$Player.unblock()

