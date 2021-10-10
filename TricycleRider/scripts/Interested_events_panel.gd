extends Node2D

var current_event = ""

signal panel_closed

func _ready():
	pass


func _on_Interested_events_panel_visibility_changed():
	$Control/ItemList.clear()
	if visible == true:
		for i in Global.riders_dict[Global.current_rider]["events"]:
			if Global.riders_dict[Global.current_rider]["events"][i].has("interested"):
				$Control/ItemList.add_item(i)


func _on_Back_buttton_pressed():
	emit_signal("panel_closed")
	hide()
