extends Node2D

var current_name = ""


func _ready():
	Http.connect("auth_data_loaded", self, "on_auth_loaded")
	Http.connect("event_data_loaded", self, "on_events_loaded")
	Http.connect("rider_data_loaded", self, "on_riders_loaded")
	Global.load_event_file()
	Global.load_rider_file()
	Global.load_auth_file()
	
	$Control/Connect_panel.hide()
	pass
	
	
func on_riders_loaded():
	pass
	
func on_events_loaded():
	pass
	
func on_auth_loaded():
#	pass
#	print("auth")
	$Control/ItemList.clear()
	for i in Global.auth_dict:
		$Control/ItemList.add_item(i)
		# + "  " + Global.auth_dict[i])

func _on_Log_in_button_pressed():
	$Control/Connect_panel.show()
	var user = $Control/Panel2/username_edit.text
	var passwd = $Control/Panel2/password_edit.text
	
	if Global.auth_dict.has(user):
		if Global.auth_dict[user] == passwd:
			$Control/Connect_panel/Panel/Label.text = "user authenticated"
			print("user authenticated")
			$Control/Connect_panel/Timer.start()
			Global.current_rider = user
			
			get_tree().change_scene("res://scenes/Rider_main.tscn")
		else:
			$Control/Connect_panel/Panel/Label.text = "access denied.  incorrect password"
			print("access denied.  incorrect password")
			$Control/Connect_panel/Timer.start()
			
	else:
		$Control/Connect_panel/Panel/Label.text = "unable to log on.  plz check credentials"
		print("access denied.  check credentials")
		$Control/Connect_panel/Timer.start()

func _on_Timer_timeout():
	$Control/Connect_panel.hide()
	$Control/Connect_panel/Panel/Label.text = "attempting to connect"


func _on_Create_button_pressed(): 
	var user = $Control/Panel3/username_edit.text
	var passwd = $Control/Panel3/password_edit.text
	if !Global.auth_dict.has(user):
		if passwd == $Control/Panel3/password_edit2.text:
			create_new_account(user, passwd)
			get_tree().change_scene("res://scenes/Rider_main.tscn")
			
		else:
			$Control/Connect_panel/Panel/Label.text = "passwords do not match"
			$Control/Connect_panel/Timer.start()
			$Control/Connect_panel.show()
	else:
		$Control/Connect_panel/Panel/Label.text = "there is already and account with that name"
		$Control/Connect_panel/Timer.start()
		$Control/Connect_panel.show()
		
func create_new_account(_user, _passwd):
	Global.auth_dict[_user] = _passwd
	Global.save_auth_file()
			
	Global.riders_dict[_user] = {}
	Global.current_rider = _user
	
	if !Global.riders_dict[_user].has("name"):
		Global.riders_dict[_user]["name"] = _user
	if !Global.riders_dict[_user].has("address"):
		Global.riders_dict[_user]["address"] = "none"
	if !Global.riders_dict[_user].has("email"):
		Global.riders_dict[_user]["email"] = "none"
	if !Global.riders_dict[_user].has("phone"):
		Global.riders_dict[_user]["phone"] = "none"
	if !Global.riders_dict[_user].has("address"):
		Global.riders_dict[_user]["address"] = "none"
	if !Global.riders_dict[_user].has("trikes"):
		Global.riders_dict[_user]["trikes"] = {}
	if !Global.riders_dict[_user].has("events"):
		Global.riders_dict[_user]["events"] = {}	
	Global.save_rider_file()
	print(Global.riders_dict[_user])


func _on_Delete_button_pressed():
	print("removing " + current_name + ".......")
	if current_name != "":
		Global.riders_dict.erase(current_name)
	for i in Global.events_dict:
		if Global.events_dict[i]["riders_list"].has(current_name):
			Global.events_dict[i]["riders_list"].erase(current_name)
	Global.auth_dict.erase(current_name)
	Global.save_auth_file()
	Global.save_event_file()
	Global.save_rider_file()
	print("user removed!")			

func _on_ItemList_item_selected(index):
	current_name = $Control/ItemList.get_item_text(index)

func _on_Quit_button_pressed():
	get_tree().quit()
