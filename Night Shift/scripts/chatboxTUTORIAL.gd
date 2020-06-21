extends Label

var drawTextSpeed:int = 0 #speed at which text is drawn
var chatterLimit: int=56 #chatbox character limit

#var chatList: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _showChatter():
	if drawTextSpeed < chatterLimit:
		drawTextSpeed += 1
		self.visible_characters = drawTextSpeed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_showChatter()
