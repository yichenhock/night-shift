extends Area2D
class_name Coin
signal dropped()
signal picked()
var off_table = false
var last_position = Vector2()

var selected = false

func _ready():
	pass # Replace with function body.

func _on_coin_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"): 
		emit_signal("picked")
		
func _physics_process(delta): 
	if selected: 
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
		#coin shadow!
		$coinClicked.position = (Vector2(210,135)-global_position)*0.1
	else: 
		
		if off_table == true: 
			global_position = lerp(global_position, last_position, 40*delta)
			if global_position == last_position:
				off_table = false
			
	$coin.material.set_shader_param("shadow", selected)
	$coinClicked.visible = selected


func _input(event):
	if event is InputEventMouseButton: 
		if event.button_index == BUTTON_LEFT and not event.pressed: 
			if selected: 
				emit_signal("dropped")
			selected = false
