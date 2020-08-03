extends  ShopEnv

func _ready(): 
	if Data.get_data("firstText",true): 
		$uiTextAnim.play("fadeOut")
		Data.set_data("firstText",false)
