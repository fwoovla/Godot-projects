extends Node2D


var current_event = ""

signal panel_closed





func _on_Back_button_pressed():
	emit_signal("panel_closed")
	hide()


func _on_Available_events_panel_visibility_changed():
	$Control/ItemList.clear()
	if visible == true:
		for i in Global.events_dict:
			if i != "placeholder":
				$Control/ItemList.add_item(i)


func _on_ItemList_item_selected(index):
	current_event = $Control/ItemList.get_item_text(index)


func _on_Mark_button_pressed():
	if current_event != "":
		Global.riders_dict[Global.current_rider]["events"][current_event] = {}
		Global.riders_dict[Global.current_rider]["events"][current_event]["interested"] = "yes"	
		Global.events_dict[current_event]["riders_list"][Global.current_rider] = {"trikes": {}, "total_paid": "0"}
		Global.save_event_file()
		Global.save_rider_file()
