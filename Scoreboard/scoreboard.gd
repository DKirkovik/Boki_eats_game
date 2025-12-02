extends Control

##Container for score
@export var score_container : PackedScene
@onready var names_container = $Panel/ScoreContainer/NamesContainer
@onready var play = $Panel/ButtonContainer/HBoxContainer/Play

func _ready():
	if GameManager.all_player_list.is_empty():
		play.hide()
	else:
		fill_container(GameManager.all_player_list)

func fill_container(list) ->void:
	for p in list:
		instant_score_name_cont(p.player_name,p.score)

func instant_score_name_cont(names,scores) ->void:
	var score_container_inst = score_container.instantiate()
	score_container_inst.set_params(names,scores)
	names_container.add_child(score_container_inst)

func _on_play_pressed():
	GameManager.change_game_scene()

func _on_back_pressed():
	GameManager.change_menu_scene()
