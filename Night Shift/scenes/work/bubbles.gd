extends Position2D

export(NodePath) var buttons_path 
onready var buttons = get_node(buttons_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize() 
	for button in buttons.get_children():
		button.connect("focus_entered",self,"on_button_focused",[button])
	update_circles()
	

func update_circles():
	$circle0.visible = true
	$circle1.visible = true
	$circle2.visible = true
	
	$circle0.position = $bubblesEnd.position*0.1 + Vector2(rand_range(-0.2,0.2),rand_range(-0.2,0.2))
	$circle1.position = $bubblesEnd.position*0.35 + Vector2(rand_range(-0.2,0.2),rand_range(-0.2,0.2))
	$circle2.position = $bubblesEnd.position*0.6 + Vector2(rand_range(-0.2,0.2),rand_range(-0.2,0.2))
	
func change_location(location): 
	$bubblesEnd.position = location - position
	update_circles()
	
func on_button_focused(button): 
	change_location(button.get_node("HBox/indicator").rect_global_position + Vector2(-10,8))


func _on_Timer_timeout():
	update_circles()
