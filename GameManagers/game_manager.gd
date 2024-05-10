extends Node

signal score_changed(score:float)
signal lives_changed(lives:int)
signal game_over()
signal jelly_powerup(_time:float)
signal scene_changed()
signal mute_audio()


var max_score:float
var score:float
var is_game_over:bool = false
var lives:int

var game_scene: PackedScene = load("res://World/world.tscn")
var menu_scene: PackedScene = load("res://GUI/main_menu/main_menu.tscn")


func on_score_changed(_score:float) ->void:
	if !is_game_over:
		score += _score
		score_changed.emit(score)
	
func get_score() ->float:
	return score

func set_lives(_lives:int) ->void:
	lives = _lives
	lives_changed.emit(lives)
	
func get_lives() ->int:
	return lives

func on_lives_changed(_lives:float) ->void:
	if lives >0:
		lives+= _lives
		lives_changed.emit(lives)
	elif !is_game_over:
		is_game_over = true
		game_over.emit()

func change_game_scene() ->void:
	get_tree().change_scene_to_packed(game_scene)
	scene_changed.emit()
	
	
func change_menu_scene() ->void:
	get_tree().change_scene_to_packed(menu_scene)
	scene_changed.emit()

func one_up(_lives:int) ->void:
	lives +=_lives
	lives_changed.emit(lives)
