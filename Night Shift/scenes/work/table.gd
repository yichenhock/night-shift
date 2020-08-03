extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var penny = $coins.get_resource("1").instance()
	var pound = $coins.get_resource("100").instance()
	var twenty = $coins.get_resource("20").instance()
	
	add_child(penny)
	penny.connect("dropped",self,"item_dropped",[penny])
	penny.connect("picked",self,"item_picked",[penny])
	penny.global_position = Vector2(100,100)
	
	add_child(pound)
	pound.connect("dropped",self,"item_dropped",[pound])
	pound.connect("picked",self,"item_picked",[pound])
	pound.global_position = Vector2(50,100)
	
	add_child(twenty)
	twenty.connect("dropped",self,"item_dropped",[twenty])
	twenty.connect("picked",self,"item_picked",[twenty])
	twenty.global_position = Vector2(50,100)
	
func _process(delta):
	$mouse.global_position = get_global_mouse_position()
	
func item_picked(item): 
	
	var was_on_top = true
	var was_on_coin = false

	for i in $mouse.get_overlapping_areas(): 
		if i is Coin: 
			was_on_coin = true
			if item.get_index() < i.get_index(): 
				was_on_top = false

	if was_on_coin: 
		if was_on_top: 
			move_child(item, get_child_count() - 1)
			item.selected = true
	else:
		move_child(item, get_child_count() - 1)
		item.selected = true
	
func item_dropped(item): 
	if not $Area2D.overlaps_area(item):
		
		# get closest point to area2d
		item.last_position = item.global_position
		var ext = $Area2D/rect.shape.get_extents()*2
		
		if item.last_position.x <= ($Area2D/rect.position.x - ext.x): 
			item.last_position.x = $Area2D/rect.position.x - ext.x
		elif item.last_position.x >= ($Area2D/rect.position.x + ext.x):
			item.last_position.x = $Area2D/rect.position.x + ext.x
	
		if item.last_position.y <= ($Area2D/rect.position.y - ext.y): 
			item.last_position.y = $Area2D/rect.position.y - ext.y
		elif item.last_position.y >= ($Area2D/rect.position.y + ext.y):
			item.last_position.y = $Area2D/rect.position.y + ext.y
		
		item.off_table = true
	
	var landed_on_coin = false
	for i in item.get_overlapping_areas(): 
		if i is Coin: 
			landed_on_coin = true
			i.global_position = i.global_position + Vector2(rand_range(-0.8,0.8),rand_range(-0.8,0.8))
	if landed_on_coin: 
		Audio.play("coinCoinSFX")
	else: 
		Audio.play("coinTableSFX")

func spawn_coins(amount, change): #amount: what is supposed to be given, change: any money given too much or too little
	pass
