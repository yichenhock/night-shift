extends Node2D
var scroll_x = 0
#onready var camera = $Player/camera

func _ready():
	#camera.offset.x = $Player.position.x
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): # delta in seconds
	# Scroll background
	scroll_x -= 10*delta
	$sky/bg.motion_offset.x = scroll_x*0.05
	$sky/fg1.motion_offset.x = scroll_x*0.2
	$sky/fg2.motion_offset.x = scroll_x
	
	#if camera.offset.x < $Player.position.x:
	#	camera.offset.x += $Player.walk_speed*delta
		
	#if camera.offset.x > $Player.position.x:
	#	camera.offset.x -= $Player.walk_speed*delta
