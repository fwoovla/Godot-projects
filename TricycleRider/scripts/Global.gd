extends Node

var riders_file_path = "riders.tm"
var riders_file :File
var riders_dict = {}

var events_file_path = "events.tm"
var events_file :File
var events_dict = {} 

var auth_dict = {}

var current_rider = ""

func make_new_riders_file():
	riders_file.open(riders_file_path, File.WRITE)
	riders_file.store_string(to_json(riders_dict))
	riders_file.close()


func make_new_event_file():
	events_file.open(events_file_path, File.WRITE)
	events_file.store_string(to_json(events_dict))
	events_file.close()
	
func add_new_event(new_event:Dictionary):
	events_dict[new_event.name] = new_event	
	print(events_dict)

func save_event_file():
	print("saving")
	Http.write_events_json(events_dict)
	
func load_event_file():
	var data = Http.read_events_json()

func load_rider_file():
	var data = Http.read_riders_json()

func load_auth_file():
	var data = Http.read_auth_json()

func add_new_rider(new_rider:Dictionary):
	riders_dict[new_rider.name] = new_rider
	print(riders_dict)	
	
func save_rider_file():
	print("saving")
	Http.write_riders_json(riders_dict)

func save_auth_file():
	print("saving")
	Http.write_auth_json(auth_dict)
