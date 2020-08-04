extends Area2D
class_name BankNote
signal dropped()
signal picked()
signal flipped()
var off_table = false
var last_position = Vector2()
var crumpled = true

var selected = false

func _ready():
	crumple(crumpled)
	
func crumple(crumpled): 
	$note.visible = !crumpled
	$noteClicked.visible = !crumpled
	$CollisionShape2D.visible = !crumpled
	$crumpled.visible = crumpled
	$crumpledShadow.visible = crumpled
	$CollisionPolygon2D.visible = crumpled

func _on_bankNote_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"): 
		emit_signal("picked")
	elif Input.is_action_just_pressed("right_click"):
		emit_signal("flipped")
		if crumpled:
			crumpled = false
			crumple(crumpled)
			Audio.play("uncrumpleSFX")

func _physics_process(delta): 
	if selected: 
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
		#note shadow!
		$noteClicked.position = (Vector2(210,135)-global_position)*0.1
		$crumpledShadow.position = (global_position-Vector2(210,135))*0.1
	else: 
		$crumpledShadow.position = Vector2(0,0)
		if off_table == true: 
			global_position = lerp(global_position, last_position, 40*delta)
			if global_position == last_position:
				off_table = false
			
	if crumpled:
		$crumpled.visible = !selected
		$crumpledClicked.visible = selected
	else: 
		$note.material.set_shader_param("shadow", selected)
		$noteClicked.visible = selected

func _input(event):
	if event is InputEventMouseButton: 
		if event.button_index == BUTTON_LEFT and not event.pressed: 
			if selected: 
				emit_signal("dropped")
			selected = false
