extends KinematicBody2D
class_name Player
enum Direction {LEFT, RIGHT}
export var walk_speed = (19*2)/0.6
export(bool) var smooth_movement = false 
export var using_camera = false
#var input_block = false setget set_input_block

# Called when the node enters the scene tree for the first time.
func _ready():
	if using_camera: 
		$camera.current = true

func _physics_process(delta):
	var direction = 0
	if Input.is_action_pressed("left"):
		direction -=1
	if Input.is_action_pressed("right"):
		direction +=1
		
	if direction != 0: 
		$AnimationPlayer.play("walk")
		
		if smooth_movement:
			move_and_collide(Vector2(direction*walk_speed*delta,0))
		# position.x += direction*delta*speed
		
		if direction < 0: 
			set_facing(Direction.LEFT)
		else: 
			set_facing(Direction.RIGHT)
	else: 
		$AnimationPlayer.play("idle")

func move(pixels:int):
	if smooth_movement: 
		return
	var direction
	if $Sprite.scale.x < 0: 
		direction = 1
	else: 
		direction = -1
		
	move_and_collide(Vector2(direction*pixels*2,0))

func set_facing(new_facing):
	if new_facing == Direction.LEFT: 
		$Sprite.scale.x = 2
	else: 
		$Sprite.scale.x = -2

func show_speech(text,left=false): 
	block() 
	
func show_options(text, left=false):
	block() 
	
func block(): 
	$AnimationPlayer.play("idle")
	set_physics_process(false)
	set_process_input(false)
	
func unblock(): 
	set_physics_process(true)
	set_process_input(true)
