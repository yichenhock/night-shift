extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	for item in $UI/shop_ui/check_stock.get_children(): 
		item.visible = false
	$UI/options/buttons/option1.grab_focus()
	$UI/speech.speech_pos = $customer.get_node("speech_pos").global_position
	$UI/speech.show_speech("It's been a long day, I need a fag.")
	$UI/radio.visible = false
	
func _input(event):
	if event.is_action_pressed("z"): # Show 
		for item in $UI/shop_ui/check_stock.get_children(): 
			item.show()
			
	if event.is_action_released("z"):
		for item in $UI/shop_ui/check_stock.get_children(): 
			item.hide()

func _on_shop_ui_radio_pressed():
	$UI/radio.visible = true
	get_tree().paused = true

func _on_radio_returned():
	get_tree().paused = false
	
