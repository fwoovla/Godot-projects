extends Node2D

var current_rider = ""

signal panel_closed

func _ready():
	pass



func _on_Cancel_button_pressed():
	emit_signal("panel_closed")
	self.hide()


func _on_Add_button_pressed():
	var new_trike = {}
	
	for i in $Control/Edit.get_children():
		new_trike[i.name] = i.text
	new_trike["insured"] = "no"
	new_trike["policy_number"] = ""
	Global.riders_dict[current_rider]["trikes"][new_trike.type] = new_trike
	Global.save_rider_file()
	_on_Cancel_button_pressed()


func _on_Add_trike_panel_visibility_changed():
	if visible == true:
		for i in $Control/Edit.get_children():
			i.clear()
