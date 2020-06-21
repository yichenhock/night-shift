extends Control
var money 
var item_amount = {}
var node
var green = "#89d474"
var red = "#c18076"
var white = "#deebd3"

# Called when the node enters the scene tree for the first time.
func _ready():
	item_amount = Data.get_data("item_amount",{})
	for node in $VBoxContainer2/HBoxContainer.get_children():
		node.connect("focus_entered",self,"on_button_focus_entered",[node])
		node.set_amount(item_amount.get(node.name,0))
		
	$VBoxContainer/day.text = "Day "+str(Data.get_data("day",0))
		
	money = Data.get_data("money",100)
	disp_money(money)
	$VBoxContainer2/HBoxContainer/gum.grab_focus()
	
		
func on_button_focus_entered(button): 
	$VBoxContainer2/description.text = button.item_name
	$VBoxContainer2/description.set("custom_colors/font_color",Color(white))
	
func _input(event):
	if event.is_action_pressed("ui_accept"): 
		node = get_focus_owner()
		if node.item_cost > money: 
			$VBoxContainer2/description.text = "You can't afford this"
			$VBoxContainer2/description.set("custom_colors/font_color",Color(red))
		else: 
			money = money - get_focus_owner().item_cost
			disp_money(money)
			Data.set_data("money",money)
			item_amount[node.name] = item_amount.get(node.name,0) + 1
			node.set_amount(item_amount[node.name])
			Data.set_data("item_amount",item_amount)
	elif event.is_action_pressed("q"):
		pass
		#change_environment("shopFront")
		
func disp_money(money): 
		if money == 0:
			$VBoxContainer/money.bbcode_text = "[center]You have [color="+red+"]$"+str(money)+"[/color][/center]"
			$finishFlash.play("flash")
		else: 
			$VBoxContainer/money.bbcode_text = "[center]You have [color="+green+"]$"+str(money)+"[/color][/center]"
