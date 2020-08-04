extends Node2D

var change_needed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for node in $UI/options.get_children():
		node.fade_in()
		
	var amt = 1015
	$UI/itemSum/amount.text = "£%.2f" % (amt*0.01) 
	spawn_coins(amt)
	
func random_int(min_value,max_value, inclusive_range = true):
	if inclusive_range:
		max_value += 1
	var range_size = max_value - min_value
	return (randi() % int(range_size)) + min_value
	
func spawn_coins(amount):
	randomize()
	var left_over = amount
	var coin_values = [] # array to be appended with coins of correct value
	
	var coin_floats = []                         
	for coin in $cash.get_resource_list():  # get coins from resource reloader as floats
	  coin_floats.append(coin.to_float())    
	coin_floats.sort()
	coin_floats.invert()
	
	for coin in coin_floats:
		var n = int(floor(left_over/coin))
		if n != 0:
			if coin > 10:
				n = random_int(ceil(n*0.7)-1,n)
			for i in range(n):
				coin_values.append(coin)
			left_over -= coin*n
			if left_over == 0: 
				break
	
	coin_values.shuffle()
	for coin in coin_values: 
		load_cash(coin)
	
func load_cash(cash_value): 
	randomize()
	
	var c = $cash.get_resource(str(cash_value)).instance()
	add_child(c)
	
	if c is Coin:
		var slideSFX = ["coinSlideSFX1","coinSlideSFX2","coinSlideSFX3"]
		Audio.play(slideSFX[randi() % slideSFX.size()])
	
	c.connect("dropped",self,"item_dropped",[c])
	c.connect("picked",self,"item_picked",[c])
	var ext = $Area2D/rect.shape.get_extents()*1.5 # reduced by factor of a bit
	$Tween.interpolate_property(c, "global_position",
			Vector2(rand_range(140,420-140),0), Vector2(rand_range($Area2D/rect.position.x - ext.x,$Area2D/rect.position.x + ext.x), rand_range($Area2D/rect.position.y - ext.y,$Area2D/rect.position.y + ext.y)), 0.4,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	
func _process(delta):
	$mouse.global_position = get_global_mouse_position()
	
func item_picked(item): 
	var was_on_top = true
	var was_on_coin = false

	for i in $mouse.get_overlapping_areas(): 
		if i is Coin or BankNote: 
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
	var landed_on_note = false
	for i in item.get_overlapping_areas(): 
		if i is Coin: 
			landed_on_coin = true
			if not item is BankNote: 
				i.global_position = i.global_position + Vector2(rand_range(-0.8,0.8),rand_range(-0.8,0.8))
		elif i is BankNote: 
			landed_on_note = true
			
	if item is Coin: 
		if landed_on_coin: 
			Audio.play("coinCoinSFX")
		elif landed_on_note: 
			Audio.play("coinNoteSFX")
		else: 
			Audio.play("coinTableSFX")

	
	
