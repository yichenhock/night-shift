extends ShopEnv
var shutterOpen = false
var drawerScene = preload("res://scenes/house/drawer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if Data.get_data("shutter_open",false): 
		$shutter.frame = 6
		shutterOpen = true
	else: 
		$shutter.frame = 0
		shutterOpen = false
		
	$money.visible = false
	$CanvasLayer/drawer.visible = false

func _on_shutterInteract_interacted():
	if shutterOpen == true: 
		$shutter/openClose.play("close")
	else: 
		$shutter/openClose.play("open")
	shutterOpen = !shutterOpen
	Data.set_data("shutter_open",shutterOpen)


func _on_cashier_interacted():
	$openCashier.play("showMoney")

func _on_cashier_player_exited():
	$openCashier.play("hideMoney")

func _on_storeCupboard_interacted():
	$CanvasLayer/drawer.visible = true
	get_tree().paused = true # set it to process to prevent infinite pause mode

func _on_drawer_returned():
	get_tree().paused = false
