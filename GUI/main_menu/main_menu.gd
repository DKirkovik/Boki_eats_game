extends Control

@onready var main_menu_music = $MainMenuMusic

func _process(delta):
	if Input.is_action_just_pressed("mute"):
		music_settings()
		GameManager.mute_audio.emit()

func _on_start_pressed():
	GameManager.change_game_scene()


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
