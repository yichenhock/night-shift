extends KinematicBody2D

export(int) var speed = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)

func get_input(): 
	var velocity = Vector2()
	if Input.is_action_pressed("left"): 
		velocity.x -= 1
	elif Input.is_action_pressed("right"):
		velocity.x += 1
		
	velocity = velocity.normalized() * speed
	return velocity
	
func _physics_process(delta): 
	move_and_collide(get_input()*delta)
