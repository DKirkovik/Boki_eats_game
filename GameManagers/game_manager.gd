extends Node

signal score_changed(score:float)
signal lives_changed(lives:int)
signal game_over()
signal jelly_powerup(_time:float)
signal scene_changed()
signal mute_audio()
signal game_start()
signal player_name_changed
signal game_paused()

var max_list_size := 10
var max_score:float
var score:float
var is_game_over:bool = false
var lives:int
var cur_player_stats : PlayerStats
var all_player_list : Array[PlayerStats]
var cur_player_name

var game_scene: PackedScene = load("res://World/world.tscn")
var menu_scene: PackedScene = load("res://GUI/main_menu/main_menu.tscn")
var scoreboard_scene:PackedScene = load("res://Scoreboard/scoreboard.tscn")

func _ready():
	game_over.connect(_on_game_over)
	fill_list()

func on_score_changed(_score:float) ->void:
	if !is_game_over:
		score += _score
		score_changed.emit(score)
		if score > max_score:
			max_score = score
	
func get_score() ->float:
	return score

func reset_score() ->void:
	score = 0
	score_changed.emit(score)

func set_lives(_lives:int) ->void:
	lives = _lives
	lives_changed.emit(lives)
	
func get_lives() ->int:
	return lives

func on_lives_changed(_lives:float) ->void:
	if lives > 0:
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

func change_scoreboard_scene() ->void:
	get_tree().change_scene_to_packed(scoreboard_scene)
	scene_changed.emit()

func one_up(_lives:int) ->void:
	lives +=_lives
	lives_changed.emit(lives)

func set_player_name(p_name : String) ->void:
	cur_player_name = p_name
	player_name_changed.emit()

func init_player() ->void:
	cur_player_stats = PlayerStats.new()
	cur_player_stats.player_name = cur_player_name
	cur_player_stats.score = score
	

func update_player_list() ->void:
	if all_player_list.size() >= max_list_size:
		print("list big")
		replace_item_in_list()
		return
	all_player_list.append(cur_player_stats)
	all_player_list.sort_custom(custom_sorting)
	

func _on_game_over() ->void:
	init_player()
	update_player_list()
	
func custom_sorting(a: PlayerStats, b: PlayerStats):
	if a.score > b.score:
		return true
	else:
		return false
		
func replace_item_in_list() ->void:
	for i in range(all_player_list.size()):
		if all_player_list[i].score < score:
			all_player_list.insert(i,cur_player_stats)
			all_player_list.pop_back()
			all_player_list.sort_custom(custom_sorting)
			return


func fill_list() ->void:
	for i in range(10):
		var cur_player_ = PlayerStats.new()
		cur_player_.player_name = "Darko " + str(i)
		cur_player_.score = i
		all_player_list.append(cur_player_)
		all_player_list.sort_custom(custom_sorting)
		

func clear_name() ->void:
	cur_player_name = null
	player_name_changed.emit()
	
