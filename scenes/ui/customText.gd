extends RichTextLabel
enum VAlign {TOP, CENTER, BOTTOM}
export(VAlign) var v_align = VAlign.TOP setget set_v_align
export var delay = 0.1
signal fully_displayed()
const char_delays = {
	".": 5, 
	",": 3,
	"!": 6, 
	"?": 6, 
	":": 2, 
	";": 2
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_v_align(new_v_align):
	v_align = new_v_align
	if v_align == VAlign.TOP: 
		pass
	elif v_align == VAlign.CENTER:
		pass
	else: #BOTTOM
		pass

func _on_typeTimer_timeout():
	type_character()
	wait_for_next_character()

func type_character(): 
	visible_characters+=1
	
func wait_for_next_character(): 
	if visible_characters == get_text().length(): 
		emit_signal("fully_displayed")
		return
	var next_character = get_text()[visible_characters-1] 
	var char_delay = delay
	if next_character in char_delays: 
		char_delay = char_delays[next_character]
		
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

