extends Control

@export var score_container : PackedScene
@onready var names_container = $Panel/ScoreContainer/NamesContainer



func fill_container(score_list) ->void:
	for score in score_list:
		instant_score_name_cont(score.player_name,score.player_score)
		


func instant_score_name_cont(names,scores) ->void:
	var score_container_inst = score_container.instantiate()
	score_container_inst.set_params(names,scores)
	names_container.add_child(score_container_inst)
