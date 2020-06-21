tool
extends TextureRect
export(Texture) var image setget set_image

func _ready():
	pass # Replace with function body.

func set_image(new_image):
	image = new_image
	$itemImg.texture = new_image

func set_amount(new_amount): 
	$stock.text = str(new_amount)

func show():
	$showHide.play("show")
	
func hide():
	$showHide.play("hide")
