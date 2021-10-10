extends Node2D

onready var current_rider = Global.current_rider
var current_trike = ""

func _ready():
	$Add_trike_panel.connect("panel_closed", self, "on_panel_closed")
	$Trike_info_panel.connect("panel_closed", self, "on_panel_closed")
	$Events_panel.connect("panel_closed", self, "on_panel_closed")
	
	if !Global.riders_dict[current_rider].has("name"):
		Global.riders_dict[current_rider]["name"] = current_rider
	if !Global.riders_dict[current_rider].has("address"):
		Global.riders_dict[current_rider]["address"] = "none"
	if !Global.riders_dict[current_rider].has("email"):
		Global.riders_dict[current_rider]["email"] = "none"
	if !Global.riders_dict[current_rider].has("phone"):
		Global.riders_dict[current_rider]["phone"] = "none"
	if !Global.riders_dict[current_rider].has("address"):
		Global.riders_dict[current_rider]["address"] = "none"
	if !Global.riders_dict[current_rider].has("trikes"):
		Global.riders_dict[current_rider]["trikes"] = {}
	if !Global.riders_dict[current_rider].has("events"):
		Global.riders_dict[current_rider]["events"] = {}
	Global.save_rider_file()
	refresh()
	
func refresh():
	$Control/Title.text = current_rider + "'s  Info"
	$Add_trike_panel.hide()
	$Trike_info_panel.hide()
	$Events_panel.hide()
	$Control/Basic_info/address_edit.text = Global.riders_dict[current_rider]["address"]
	$Control/Basic_info/email_edit.text = Global.riders_dict[current_rider]["email"]
	$Control/Basic_info/phone_edit.text = Global.riders_dict[current_rider]["phone"]
	$Control/Basic_info/name_edit.text = Global.riders_dict[current_rider]["name"]
	$Control/Basic_info/Update_button.disabled = true
	
	$Control/Trike_control/Trike_list.clear()
	for i in Global.riders_dict[current_rider]["trikes"]:
		$Control/Trike_control/Trike_list.add_item(i)
	pass

func _on_Update_button_pressed():
	Global.riders_dict[current_rider]["address"] = $Control/Basic_info/address_edit.text
	Global.riders_dict[current_rider]["email"] = $Control/Basic_info/email_edit.text
	Global.riders_dict[current_rider]["phone"] = $Control/Basic_info/phone_edit.text
	Global.riders_dict[current_rider]["name"] = $Control/Basic_info/name_edit.text
	Global.save_rider_file()
	refresh()
	pass # Replace with function body.

func basic_edit_text_changed(new_text):
	$Control/Basic_info/Update_button.disabled = false

func _on_Add_trike_button_pressed():
	$Add_trike_panel.current_rider = current_rider
	$Add_trike_panel.show()

func on_panel_closed():
	refresh()

func _on_Logout_button_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")

func _on_Events_button_pressed():
	$Events_panel.current_rider = current_rider
	$Events_panel.show()

func _on_View_trike_button_pressed():
	if current_trike != "":
		$Trike_info_panel.current_trike = current_trike
		$Trike_info_panel.show()

func _on_Trike_list_item_selected(index):
	current_trike = $Control/Trike_control/Trike_list.get_item_text(index)
	

func _on_Remove_trike_button_pressed():
	if current_trike != "":
		for i in Global.events_dict:
			if i != "placeholder":
				if Global.events_dict[i]["riders_list"].has(current_rider):
					if Global.events_dict[i]["riders_list"][current_rider]["trikes"].has(current_trike):
						Global.events_dict[i]["riders_list"][current_rider]["trikes"].erase(current_trike)
						current_trike = ""
						
		Global.riders_dict[Global.current_rider]["trikes"].erase(current_trike)
		
		Global.save_event_file()
		Global.save_rider_file()
		refresh()


func _on_Refresh_button_pressed():
	Global.load_event_file()
	Global.load_rider_file()
	Global.load_auth_file()	
