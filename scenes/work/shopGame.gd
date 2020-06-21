extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	for item in $UI/shop_ui/check_stock.get_children(): 
		item.visible = false
	$UI/options/buttons/option1.grab_focus()
	

func _input(event):
	if event.is_action_pressed("z"): # Show 
		for item in $UI/shop_ui/check_stock.get_children(): 
			item.show()
			
	if event.is_action_released("z"):
		for item in $UI/shop_ui/check_stock.get_children(): 
			item.hide()
