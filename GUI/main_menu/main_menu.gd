extends Control

@onready var main_menu_music = $MainMenuMusic
@onready var panel_container = $CanvasLayer/MarginContainer/VBoxContainer/PanelContainer
@onready var name_container = $CanvasLayer/MarginContainer/VBoxContainer/NameContainer
@onready var player_name = $CanvasLayer/MarginContainer/VBoxContainer/NameContainer/PlayerName

var can_start = false

func _ready():
	GameManager.player_name_changed.connect(_can_start)
	panel_container.hide()
	if GameManager.cur_player_stats == null:
		name_container.hide()
	else:
		player_name.text = "Name: " + str(GameManager.cur_player_name)
		name_container.show()

func _process(delta):
	if Input.is_action_just_pressed("mute"):
		music_settings()
		GameManager.mute_audio.emit()

func _on_start_pressed():
	if can_start:
		GameManager.change_game_scene()
		can_start = false
	else:
		panel_container.show()
	
func _on_exit_pressed():
	get_tree().quit()


func _on_scores_pressed():
	OS.shell_open("https://ko-fi.com/humanbones/donate")

func music_settings() ->void:
	if main_menu_music.playing:
		main_menu_music.stop()
	else:
		main_menu_music.play()

func _on_scoreboard_pressed():
	GameManager.change_scoreboard_scene()

func _on_button_pressed():
	can_start = false
	name_container.hide()
	panel_container.show()

func _can_start() ->void:
	if GameManager.cur_player_name == null:
		can_start = false
	else:
		can_start = true
