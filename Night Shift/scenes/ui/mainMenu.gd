extends Control
var scroll_x = 0
var window_occupied = false #prevent choices
signal change_state(new_state)

func _ready():
	$ColorRect.visible = false
	$shutter.frame = 0
	$shutterAnimation.play("shutterOpen")
	Audio.play("mainMenuBGM")
	$VBox/newGame.grab_focus()
	
func _process(delta): # delta in seconds
	# Scroll background
	scroll_x -= 10*delta
	$sky/bg.motion_offset.x = scroll_x*0.05
	$sky/fg1.motion_offset.x = scroll_x*0.2
	$sky/fg2.motion_offset.x = scroll_x

func _on_newGame_pressed():
	disable_menu(true)
	$shutterAnimation.play("shutterClose")
	yield($shutterAnimation,"animation_finished")
#	get_parent().fade_in_out(5,0.5) 
#	yield(get_parent(),"f")
	$ColorRect.fade_out()
	yield($ColorRect,"fade_out_finished")
	emit_signal("change_state","monologue")

func _on_continue_pressed():
	disable_menu(true)
	$shutterAnimation.play("shutterClose")
	$fadeAnimation.queue("fadeOut")
	yield($fadeAnimation,"animation_finished")

func _on_options_pressed():
	Audio.play("menuAcceptSFX")
	disable_menu(true)
	$shutterPoster.visible = true
	$options.visible = true
	$cancel.visible = true
	if OS.window_fullscreen: 
		$options/HBoxContainer/fullscreenButton/on.visible = true
	else: 
		$options/HBoxContainer/fullscreenButton/on.visible = false

func _on_about_pressed():
	Audio.play("menuAcceptSFX")
	disable_menu(true)
	$shutterPoster.visible = true
	$about.visible = true
	$cancel.visible = true
	
func _on_quit_pressed():
	get_tree().quit()

func _on_ig_pressed():
	OS.shell_open("https://www.instagram.com/chen_dll/")

func _on_twitter_pressed():
	OS.shell_open("https://twitter.com/chen_dll")

func _on_fb_pressed():
	OS.shell_open("https://www.facebook.com/profile.php?id=100004854345993")

func _on_cancel_pressed():
	disable_menu(false)
	$shutterPoster.visible = false
	if $options.visible: 
		$options.visible = false
		$VBox/options.grab_focus()
	if $about.visible: 
		$about.visible = false
		$VBox/about.grab_focus()
	$cancel.visible = false

func _input(event):
	if event.is_action_pressed("ui_cancel") :
		_on_cancel_pressed()

func _on_fullscreenButton_pressed():
	if $options/HBoxContainer/fullscreenButton/on.visible: 
		$options/HBoxContainer/fullscreenButton/on.visible = false
		OS.window_fullscreen = false
	else: 
		$options/HBoxContainer/fullscreenButton/on.visible = true
		OS.window_fullscreen = true

func disable_menu(state): 
	for node in $VBox.get_children(): 
		if node.get_class() == "TextureButton": 
			node.disabled = state

func _on_volSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(value))
	Data.set_data("volume",value)
