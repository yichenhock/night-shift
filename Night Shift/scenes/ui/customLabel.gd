extends Label
export(String) var blip_sfx = "" setget set_blip_sfx
export var delay = 0.1
signal fully_displayed()
signal character_displayed()
const char_delays = {
	".": 5, 
	",": 3,
	"!": 6, 
	"?": 6, 
	":": 2, 
	";": 2
}

func set_blip_sfx(new_sfx): 
	blip_sfx = new_sfx

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_typeTimer_timeout():
	type_character()
	wait_for_next_character()

func type_character(): 
	if blip_sfx!="":
				Audio.play(blip_sfx)
	visible_characters+=1
	emit_signal("character_displayed")
	
func wait_for_next_character(): 
	if text != "": 
		if visible_characters == get_text().length(): 
			emit_signal("fully_displayed")
			return
		var next_character = get_text()[visible_characters-1] 
		var char_delay = delay
		if next_character in char_delays: 
			char_delay = char_delays[next_character]*delay
#		else: 
#			if blip_sfx!="":
#				Audio.play(blip_sfx)
#				print(get_text()[visible_characters-1] )
			
		$typeTimer.start(char_delay) 
	
func get_text(): 
	return text
	
func type_text(new_text): 
	set_text(new_text)
	visible_characters = 0
	type_character()
	wait_for_next_character()
	
func set_text(new_text): 
	text = new_text
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"): 
		if not $typeTimer.is_stopped(): 
			$typeTimer.stop()
			get_tree().set_input_as_handled()
			percent_visible = 1
			emit_signal("fully_displayed")
			emit_signal("character_displayed")

