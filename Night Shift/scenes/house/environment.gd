extends Node2D
class_name ShopEnv
signal changed_environment(new_name) # convention underscore and past tense

func change_environment(new_name):
	emit_signal("changed_environment", new_name)

func _ready(): 
	pass
