extends Control
signal radio_pressed()

func _ready():
	
	var drugs_bought = Data.get_data("drugs_bought", false)
	var drugs_taken = Data.get_data("drugs_taken",0)
	
	for node in get_children(): 
		if node.get_name().substr(0,5) == "pills": 
			node.visible = false
	if drugs_bought == true: 
		for node in get_children(): 
			if node.get_name() == "pills"+str(3-drugs_taken): 
				node.visible = true
		
func _on_radio_pressed():
	emit_signal("radio_pressed")
