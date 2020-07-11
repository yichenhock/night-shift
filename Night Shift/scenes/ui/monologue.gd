extends Control
var n = 0
signal change_state(new_state)
var text = [
	"I opened a shop recently. Things havent been going so well financially",
	"steve was a nice man",
	"until i killed him...", 
	"lmao"
	]

# Called when the node enters the scene tree for the first time.
func _ready():
	Audio.stop_all()
	$text.type_text(text[n])
	
	var firstText = Data.get_data("firstText",true)
	if firstText: 
		$indicatorAnimation.play("showInstructions")
	else: 
		$uiText.visible = false
		$indicatorAnimation.play("still")
		
		
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"): 
		n += 1
		$text.type_text(text[n%len(text)])
		if len(text) == n: 
			emit_signal("change_state", "houseGame") 
	
func _input(event):
	if event.is_action_pressed("ui_accept"): 
		if Data.get_data("firstText",true): 
			$indicatorAnimation.play("transition")
			$indicatorAnimation.queue("still")
			Data.set_data("firstText", false)
		else: 
			$indicatorAnimation.play("still")

func _on_text_fully_displayed():
	if not Data.get_data("firstText",true): 
#		$indicatorAnimation.play("transition")
#		$indicatorAnimation.queue("bob")
#		Data.set_data("firstText", false)
#	else: 
		$indicatorAnimation.queue("bob")
	
