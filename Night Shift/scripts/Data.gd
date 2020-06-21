extends Node

const SAVE_PATH = "user://main.save"
export(int) var SAVE_VERSION = 0

var data = {}

func get_data(key,default=null):
	if data.has(key):
		return data[key]
	return default

func set_data(key,val): 
	data[key] = val

func save_data(): 
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	save_file.store_string(to_json(data))
	save_file.close()
	
func load_data(): 
	var save_file = File.new()
	if save_file.file_exists(SAVE_PATH): 
		# Opening file
		save_file.open(SAVE_PATH, File.READ)
		var file_data = parse_json(save_file.get_as_text())
		save_file.close()
		if file_data.SAVE_VERSION == SAVE_VERSION:
			data = file_data
		else: 
			load_default_data() 
	else: 
		load_default_data() 
func load_default_data(): 
	data = {}
	data.SAVE_VERSION = SAVE_VERSION
	data.zone_completed = []
	data.zones_unlocked = [0]
	data.zones_just_unlocked = []
