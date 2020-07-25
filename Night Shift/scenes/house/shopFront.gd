extends ShopEnv

# Called when the node enters the scene tree for the first time.
func _ready():
	Audio.play("windNormal")
	if Data.get_data("shutter_open",false): 
		$shutter.visible = false
	else: 
		$shutter.visible = true
	


func _on_frontDoor_interacted():
	Audio.pause("windNormal")
