tool 
extends TextureButton
export(Texture) var image setget set_image
export(String) var item_name setget set_name
export(int) var item_cost setget set_cost

func _ready():
	pass # Replace with function body.

func set_image(new_image):
	image = new_image
	$itemImg.texture = new_image

func set_name(new_name): 
	item_name = new_name
	
func set_cost(new_cost): 
	item_cost = new_cost
	$cost.text = "$"+str(new_cost)

func set_amount(new_amount): 
	$stock.text = str(new_amount)
