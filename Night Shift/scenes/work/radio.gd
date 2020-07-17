extends Control
var radio_on = false
var n = 0
var current_channel = "000.00"
var changing_channel = ""
var radio_channels = {
	"124.11": "piano", 
	"085.43": "jazz", 
	"095.35": "lo-fi", 
	"104.24": "pop", 
	"111.12": "???"
}
# Called when the node enters the scene tree for the first time.
func _ready():
	if radio_on == false: #if power off, show in off state
		turn_off()
	else: 
		turn_on()

func _on_power_pressed():
	Audio.play("radioPowerSFX")
	if radio_on == false: #if power off, turn on
		turn_on()
		radio_on = true
		play_radio()
	else: 
		turn_off()
		radio_on = false
		n = 0
		changing_channel = ""
		stop_radio()
		
func turn_on():
	$indicatorOff.visible = false
	$indicatorOn.visible = true
	$displayOff.visible = false
	$displayOn.visible = true	
	$displayText.text = current_channel # whatever previously currently playing channel was
	play_radio()
	
func turn_off(): 
	$indicatorOff.visible = true
	$indicatorOn.visible = false
	$displayOff.visible = true
	$displayOn.visible = false
	$displayText.text = "---.--"
	
func set_display(digit): 
	Audio.play("radioKeypadSFX")
	
	if radio_on == true: 
		var input_mask = "-----"
		changing_channel += str(digit) 
		var output_num = input_mask.substr(0,4-n) + str(changing_channel)
		$displayText.text = output_num.substr(0,3) +"."+ output_num.substr(3,4)
		n+=1
		$radioTimeout.start()
		if n == 5: 
			$radioTimeout.stop()
			n = 0
			changing_channel = ""
			current_channel = $displayText.text
			$flashDisplay.play("flash")
			play_radio()

func _on_radioTimeout_timeout():
	$flashDisplay.play("flash")
	var output_mask = "00000"
	var output_num = output_mask.substr(0,5-n) + str(changing_channel)
	$displayText.text = output_num.substr(0,3) +"."+ output_num.substr(3,4)
	current_channel = $displayText.text
	n = 0
	changing_channel = ""
	play_radio()
	
func play_radio(): 
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Radio"),false)
	if current_channel in radio_channels: 
		Audio.stop("radioStaticBGM")
	else: 
		Audio.play("radioStaticBGM")
		
func stop_radio(): 
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Radio"),true)
	
