tool
extends Control
signal finished()
export var delay = 0.1 setget set_delay
export var speech_pos = Vector2(0,0) setget position_speech

export(String) var blip_sfx = "" setget set_blip_sfx

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize() 
	$dialogue.type_text("Hey! I dont really like you... you make me feel liek the worst person in the world i wish you can just sepuku and kil urself ya know theres no better option, and i think itd do the world a massive favour so why dont u do it before i do it for you musef")
	resize_speech()


func set_blip_sfx(new_sfx): 
	blip_sfx = new_sfx
	$dialogue.blip_sfx = blip_sfx

func show_speech(text): 
	$dialogue.type_text(text)

func set_delay(new_delay): 
	delay = new_delay
	$dialogue.delay = delay

func _on_Timer_timeout():
	$dialogue.rect_position = Vector2(12 + rand_range(-0.6,0.6),12 + rand_range(-0.6,0.6))

func position_speech(new_pos):
	speech_pos  = new_pos 
	rect_position = new_pos - $NinePatchRect.rect_size*2

#func move_to(new_pos): 
#	rect_position = new_pos - $NinePatchRect.rect_size*2 

func resize_speech(): # ~21 chars per line
	var font = $dialogue.get_font("normal_font")
	var font_height = font.get_height()
	
	$dialogue.rect_size.x = 125
	
#	if $dialogue.text.length() < 23: 
#		$NinePatchRect.rect_size.x = 32 + ceil(($dialogue.text.length()/23.0)*38)
#	else: 
#		$NinePatchRect.rect_size.x = 70
#	$NinePatchRect.rect_size.y = ceil(font_height*$dialogue.text.length()/33.5) + 16
#	$dialogue.rect_size.y = $NinePatchRect.rect_size.y*2
	
	if $dialogue.visible_characters == -1: 
		if $dialogue.text.length() < 23: 
			$NinePatchRect.rect_size.x = 32 + ceil(($dialogue.text.length()/23.0)*38)
		else: 
			$NinePatchRect.rect_size.x = 70
		$NinePatchRect.rect_size.y = ceil(font_height*$dialogue.text.length()/33.5) + 16
		$dialogue.rect_size.y = $NinePatchRect.rect_size.y*2
	else: 
		if $dialogue.visible_characters < 23: 
			$NinePatchRect.rect_size.x = 32 + ceil(($dialogue.visible_characters/23.0)*38)
		else: 
			$NinePatchRect.rect_size.x = 70
		$NinePatchRect.rect_size.y = ceil(font_height*$dialogue.visible_characters/33.5) + 16
		$dialogue.rect_size.y = $NinePatchRect.rect_size.y*2
	
	position_speech(speech_pos)
	
func _on_dialogue_character_displayed():
	resize_speech()
	
