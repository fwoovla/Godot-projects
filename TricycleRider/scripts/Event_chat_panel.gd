extends Node2D

var current_event = ""

func _ready():
	pass


func _on_Event_chat_panel_visibility_changed():
	$Control/ItemList.clear()
	if visible == true:
		$Control/Title.text = current_event + "  Chat"
		for i in Global.events_dict[current_event]["riders_list"][Global.current_rider]["messeges"]:
			$Control/ItemList.add_item(i + "  " + Global.events_dict[current_event]["riders_list"][Global.current_rider]["messeges"][i])
			pass
		pass


func _on_Back_button_pressed():
	hide()


func _on_Send_button_pressed():
	Global.events_dict[current_event]["riders_list"][Global.current_rider]["messeges"][str(OS.get_unix_time()) + Global.current_rider] = $Control/LineEdit.text
	Global.events_dict[current_event]["messeges"][str(OS.get_unix_time()) + Global.current_rider] = $Control/LineEdit.text 
	Global.save_event_file()
	$Control/ItemList.add_item($Control/LineEdit.text)
	$Control/LineEdit.clear()	


func _on_Refresh_button_pressed():
	_on_Event_chat_panel_visibility_changed()
