tool
extends Sprite
export(Vector2) var default_pos setget set_position 
export(Vector2) var multiplier
const SPOTLIGHT_POS = Vector2(205,230)

func _process(delta):
	var spotlight_pos = get_parent().get_node("spotlight").position
	position.x = default_pos.x + multiplier.x*(spotlight_pos.x - SPOTLIGHT_POS.x)
	position.y = default_pos.y + multiplier.y*(spotlight_pos.y - SPOTLIGHT_POS.y)
	
func set_position(pos): 
	default_pos = pos
	position = default_pos
