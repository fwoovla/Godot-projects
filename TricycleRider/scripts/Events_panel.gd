extends Node2D

var current_rider = ""
var current_event = ""
var current_info = ""

signal panel_closed

func _ready():
	$Available_events_panel.connect("panel_closed", self, "on_panel_closed")
	$Interested_events_panel.connect("panel_closed", self, "on_panel_closed")
	$Invited_events_panel.connect("panel_closed", self, "on_panel_closed")	
	$Confirmed_events_panel.connect("panel_closed", self, "on_panel_closed")	
	
func _on_Cancel_button_pressed():
	emit_signal("panel_closed")
	self.hide()


func _on_Events_panel_visibility_changed():
	$Available_events_panel.hide()
	$Interested_events_panel.hide()
	$Invited_events_panel.hide()
	$Confirmed_events_panel.hide()
	$Chat_panel.hide()
	$Control/Event_list.clear()
	if visible == true:
		for i in Global.events_dict:
			$Control/Event_list.add_item(i)


func _on_Avaialble_events_button_pressed():
	$Available_events_panel.show()


func _on_Interested_events_button_pressed():
	$Interested_events_panel.show()

func on_panel_closed():
	_on_Events_panel_visibility_changed()


func _on_Invited_events_button_pressed():
	$Invited_events_panel.show()


func _on_Confirmed_events_button_pressed():
	$Confirmed_events_panel.show()


func _on_Chat_button_pressed():
	$Chat_panel.show()
