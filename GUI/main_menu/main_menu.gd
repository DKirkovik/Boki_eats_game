extends Control

@onready var main_menu_music = $MainMenuMusic


func _on_start_pressed():
	GameManager.change_game_scene()


func _on_exit_pressed():
	get_tree().quit()


func _on_scores_pressed():
	print("Scores")
