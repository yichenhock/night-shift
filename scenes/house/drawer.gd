extends Control
var item_amount = {}
signal returned()

func _ready():
	item_amount = Data.get_data("item_amount",{})
	for node in $HBox1.get_children():
		node.set_amount(item_amount.get(node.name,0))

func _input(event): 
	if visible: 
		get_tree().set_input_as_handled() #this stops other _input rom being triggered by this event
		if event.is_action_pressed("ui_accept"): 
			emit_signal("returned")
			visible = false

