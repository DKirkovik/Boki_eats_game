extends Node

signal score_changed(score:float)
signal game_over()

var max_score:float
var score:float
var is_game_over:bool



func on_score_changed(_score:float) ->void:
	score += _score
	score_changed.emit(score)
	
func get_score() ->float:
	return score
