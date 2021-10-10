extends Node2D

var events_url = "https://api.jsonbin.io/v3/b/61526c1caa02be1d444ff0c3"
var riders_url = "https://api.jsonbin.io/v3/b/614e068e4a82881d6c54d4bd"
var auth_url = "https://api.jsonbin.io/v3/b/61525758aa02be1d444feaa3"
var read_headers = ["X-Master-Key: $2b$10$XfFOmz.8g3YbZ1ijXTwvLuFYFMo53CsAgAaisy6E2YdE47c1yHELi"]
var write_hearders = ["X-Master-Key: $2b$10$XfFOmz.8g3YbZ1ijXTwvLuFYFMo53CsAgAaisy6E2YdE47c1yHELi","Content-Type: application/json", "versioning: false"]
#var auth_headers = [""]
var read_dict = {}
var write_dict = {}
var auth_dict = {}


signal rider_data_loaded
signal event_data_loaded
signal auth_data_loaded

func _ready():
	pass

func read_riders_json():
	var http = HTTPRequest.new()
	$Rider_request.request(riders_url, read_headers)

func read_events_json():
	$Event_request.request(events_url, read_headers)

func read_auth_json():
	$Auth_request.request(auth_url, read_headers)

func write_riders_json(_dict:Dictionary):
	$Rider_request.request(riders_url, write_hearders, true, HTTPClient.METHOD_PUT, JSON.print(_dict))
	pass

func write_events_json(_dict:Dictionary):
	$Event_request.request(events_url, write_hearders, true, HTTPClient.METHOD_PUT, JSON.print(_dict))
	pass

func write_auth_json(_dict:Dictionary):
	$Auth_request.request(auth_url, write_hearders, true, HTTPClient.METHOD_PUT, JSON.print(_dict))
	pass


func _on_Rider_request_request_completed(result, response_code, headers, body):
	print("got RIDERz")
	var text = JSON.parse(body.get_string_from_utf8())
	print(response_code)
	#print(text.result.record)
	
	read_dict = text.result.record
	Global.riders_dict = read_dict
	emit_signal("rider_data_loaded")
	$Request_timer.start()
	
func _on_Event_request_request_completed(result, response_code, headers, body):
	print("got EVENTS")
	var text = JSON.parse(body.get_string_from_utf8())
	print(response_code)
	#print(text.result.record)
	
	read_dict = text.result.record
	Global.events_dict = read_dict
	emit_signal("event_data_loaded")

func _on_Auth_request_request_completed(result, response_code, headers, body):
	print("got AUTH")
	var text = JSON.parse(body.get_string_from_utf8())
	print(response_code)
	#print(text.result.record)
	
	read_dict = text.result.record
	Global.auth_dict = read_dict
	emit_signal("auth_data_loaded")


func _on_Request_timer_timeout():
	read_auth_json()
	read_events_json()
	read_riders_json()
