extends Node2D

var current_evenet = ""

func _ready():
	pass

func _on_Chat_panel_visibility_changed():
	$Control/Event_list.clear()
	if visible == true:
		$Event_chat_panel.hide()
		for i in Global.events_dict:
			if Global.events_dict[i]["riders_list"].has(Global.current_rider):
				$Control/Event_list.add_item(i)
			

func _on_Back_button_pressed():
	hide()

func _on_Select_button_pressed():
	if current_evenet != "":
		$Event_chat_panel.current_event = current_evenet
		$Event_chat_panel.show()
	pass

func _on_Event_list_item_selected(index):
	current_evenet = $Control/Event_list.get_item_text(index)
