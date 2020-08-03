tool
extends Control
signal option1_clicked()
signal option2_clicked()
signal option3_clicked()


func _ready():
	$buttons/option1.visible = false
	$buttons/option2.visible = false
	$buttons/option3.visible = false
	
	$bubbles.change_location($buttons/option1.get_node("optionText").rect_global_position + Vector2(-10,8))
	
func display_options(): 
	$bubbles/bubblesAnim.play("appear")
	yield($bubbles/bubblesAnim,"animation_finished")
	$buttons/option1/AnimationPlayer.play("fadeIn")
	$dialogueTimer.start(0.1)
	yield($dialogueTimer,"timeout")
	$buttons/option2/AnimationPlayer.play("fadeIn")
	$dialogueTimer.start(0.1)
	yield($dialogueTimer,"timeout")
	$buttons/option3/AnimationPlayer.play("fadeIn")

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
	
