extends PanelContainer

@onready var line_edit = $MarginContainer2/VBoxContainer/LineEdit
@onready var ok = $MarginContainer2/VBoxContainer/MarginContainer/OK
@onready var back = $MarginContainer2/VBoxContainer/MarginContainer/Back

var line_filled := false




func _on_back_pressed():
	if self.visible:
		hide()


func _on_ok_pressed():
	if line_filled:
		GameManager.change_game_scene()
