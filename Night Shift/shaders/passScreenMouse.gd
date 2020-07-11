extends ColorRect

var mouse
var screen

func _ready():
	screen = get_viewport().get_visible_rect().size
	get_material().set_shader_param("screen_size",screen) # pass screen size on shader script
	set_process(true)

func _process(delta):
	mouse = get_node("../").get_global_mouse_position()
	# mouse.x = mouse.x / screen.x *100
	get_material().set_shader_param("mouse_position", mouse) #pass mouse position on shader script
