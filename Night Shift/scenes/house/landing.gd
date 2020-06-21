extends ShopEnv

func _ready():
	$UI/letter.visible = false
	var firstLetter = Data.get_data("firstLetter",true)
	if firstLetter: 
		show_hide_interactables(false)
	else: 
		show_hide_interactables(true)

func _on_letterInteract_interacted():
	Data.set_data("firstLetter",false)
	show_hide_interactables(true)
	$UI/letter.visible = true
	get_parent().block_player()
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"): 
		if $UI/letter.visible: 
			$UI/letter.visible = false
			get_parent().unblock_player()
	
func show_hide_interactables(state): 
	$letterSmall.visible = !state
	
	$letterInteract.active = !state
	$toiletDoor.active = state
	$stairs.active = state
	$storeDoor.active = state
	$frontDoor.active = state

	
