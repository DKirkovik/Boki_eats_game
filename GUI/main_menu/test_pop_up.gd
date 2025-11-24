extends PanelContainer

@onready var line_edit = $MarginContainer2/VBoxContainer/LineEdit
@onready var ok = $MarginContainer2/VBoxContainer/MarginContainer/OK
@onready var back = $MarginContainer2/VBoxContainer/MarginContainer/Back

func _on_back_pressed():
	if self.visible:
		GameManager.clear_name()
		hide()

func _on_ok_pressed():
	if line_edit.text.strip_edges() == "":
		line_edit.modulate = Color.CRIMSON
		return
	else:
		GameManager.set_player_name(str(line_edit.text))
		line_edit.modulate = Color.WHITE
		GameManager.change_game_scene()

func _on_line_edit_text_submitted(new_text):
	if line_edit.text.strip_edges() == "":
		line_edit.modulate = Color.CRIMSON
		return
	GameManager.set_player_name(str(line_edit.text))
	line_edit.modulate = Color.WHITE
	GameManager.change_game_scene()

func _on_line_edit_text_changed(new_text):
	line_edit.modulate = Color.WHITE
	GameManager.set_player_name(str(new_text))
