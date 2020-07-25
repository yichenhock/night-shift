extends Node2D
var n = 0
var m = 0
signal change_state(new_state)
var text0 = [
	"It’s easy to feel like I am the only person in this world. ",
	"I feel alone… but I don’t feel lonely. ",
	"The feeling of loneliness has long passed, along with an amalgamation of various emotions, ready to resurface. ", 
	"But saying that I am actually alone is a lie… since I live with my mother and have been living with her all my life. ",
	"I am gathering up my last flicker of motivation and energy to try again once more... ", 
	"I set up a shop and prepared my first round of stock, although that dried up most of my savings. ", 
	"That said, maybe this time I can turn my life around. "
	]
var text1 = ["I paid the local weekly newspaper to display an advert for my shop.",
			"Where is it..."]

func _ready():
	Audio.stop_all()
	$UI/text.type_text(text0[n])
	$newspaperCloseUp.visible = false
	$newspaper.visible = false
	$newspaperPointed.visible = false
		
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"): 
		$UI/indicatorAnimation.play("still")
		if m==0: 
			n += 1
			if n<len(text0):
				$UI/text.type_text(text0[n])
			elif n==len(text0): 
				$UI/text.text = ""
				$bgAnim.play("blobGrow")
				yield($bgAnim,"animation_finished")
				$bgAnim.play("bigBlob")
				$UI/text.type_text("Something came in the mail today.")
				n=0
				m=1
		elif m==1: 
			$UI/text.text = ""
			$bgAnim.play("mailDrop")
			yield($bgAnim,"animation_finished")
			$bgAnim.play("feet")
			$UI/indicatorAnimation.play("bob")
			m=2
		elif m==2: 
			$newspaper.visible = true
			$UI/text.type_text(text1[n])
			n+=1
			if n==len(text1): 
				m=3
		elif m==3: 
			$newspaper.visible = false
			$newspaperPointed.visible = true
			$UI/text.type_text("Aha! It's there!")
			m=4
		elif m==4: 
			$newspaperPointed.visible = false
			$newspaperCloseUp.visible = true
			$UI/text.type_text("...")
			m=5
		elif m==5: 
			$UI/text.type_text("It's smaller than I thought...")
			m=6
		elif m==6: 
			$newspaperCloseUp.visible = false
			$bgAnim.play("feetSansNews")
			$UI/text.type_text("And this...?")
			m=7
		elif m==7:
			emit_signal("change_state", "nightTransit1") 
	
func _input(event):
	pass

func _on_text_fully_displayed():
	$UI/indicatorAnimation.play("bob")
	
