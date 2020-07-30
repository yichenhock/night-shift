tool
extends Control
signal option1_clicked()
signal option2_clicked()
signal option3_clicked()
#export(String) var option1 = "" setget set_option1
#export(String) var option2 = "" setget set_option2
#export(String) var option3 = "" setget set_option3
##enum Choices {ONE,TWO,THREE,NULL = 0}
##export(Choices) var num_choices = Choices.TWO setget show_options
#
#func set_option1(new_option): 
#	option1 = new_option
#	if option1 == "": 
#		pass
##		$buttons/option1.visible = false
#	else: 
##		$buttons/option1.visible = true
#		$buttons/option1.text = option1
#
#func set_option2(new_option): 
#	option2 = new_option
#	if option2 == "": 
#		$buttons/option2.visible = false
#	else: 
#		$buttons/option2.visible = true
#		$buttons/option2.text = option2
#
#func set_option3(new_option): 
#	option3 = new_option
#	if option3 == "": 
#		$buttons/option3.visible = true
#	else: 
#		$buttons/option3.visible = false
#		$buttons/option3.text = option3
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
