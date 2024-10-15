extends Control

@onready var timer = $Timer
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var margin_container = $MarginContainer
@onready var text_timer = $TextTimer
@onready var label = $MarginContainer/Label
@onready var button_continue: Button = $MarginContainer/MarginContainerButton/VBoxContainer/Continue
@onready var texture_rect: TextureRect = $MarginContainer/TextureRect


func _ready():
	GameManager.game_paused.connect(_on_game_paused)
	GameManager.game_over.connect(on_game_over)
	margin_container.hide()
	label.hide()

func on_game_over() ->void:
	timer.start()
	button_continue.hide()
	text_timer.start()

func _on_timer_timeout():
	margin_container.show()
	audio_stream_player_2d.play()

func _on_text_timer_timeout():
	pass

func _on_game_paused() ->void:
	if !get_tree().paused:
		get_tree().paused = true
		texture_rect.hide()
		margin_container.show()
	else:
		get_tree().paused = false
		texture_rect.show()
		margin_container.hide()

func _on_again_pressed():
	get_tree().paused = false
	GameManager.change_game_scene()


func _on_exit_pressed():
	get_tree().paused = false
	GameManager.change_menu_scene()
