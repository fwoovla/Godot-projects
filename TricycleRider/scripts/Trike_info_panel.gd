extends Node2D

var current_trike = ""

signal panel_closed

func _ready():
	pass

func _on_Back_button_pressed():
	emit_signal("panel_closed")
	hide()

func _on_Trike_info_panel_visibility_changed():
	if current_trike != "":
		$Control/Label.text = current_trike + " Info"
	for i in $Control/Info_box.get_children():
		$Control/Info_box.remove_child(i)
	for i in $Control/Edit_box.get_children():
		$Control/Edit_box.remove_child(i)
		
	#Control/ItemList.clear()
	if visible == true:
		for i in Global.riders_dict[Global.current_rider]["trikes"][current_trike]:
			var label = Label.new()
			var edit = LineEdit.new()
			label.text = i
			edit.name = i
			edit.text = Global.riders_dict[Global.current_rider]["trikes"][current_trike][i]
			$Control/Info_box.add_child(label)
			$Control/Edit_box.add_child(edit)


func _on_Update_button_pressed():
	for i in $Control/Edit_box.get_children():
		print(i.name)
		Global.riders_dict[Global.current_rider]["trikes"][current_trike][i.name] = i.text
	Global.save_rider_file()
	_on_Back_button_pressed()
