extends Node

signal score_changed(score:float)
signal lives_changed(lives:int)
signal game_over()
signal jelly_powerup()

var max_score:float
var score:float
var is_game_over:bool = false
var lives:int


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
