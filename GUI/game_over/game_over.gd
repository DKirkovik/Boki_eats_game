extends Control

@onready var timer = $Timer
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var margin_container = $MarginContainer
@onready var text_timer = $TextTimer
@onready var label = $MarginContainer/Label


func _ready():
	GameManager.game_over.connect(on_game_over)
	margin_container.hide()
	label.hide()

func on_game_over() ->void:
	timer.start()
	text_timer.start()

func _on_timer_timeout():
	margin_container.show()
	audio_stream_player_2d.play()

func _on_text_timer_timeout():
	label.show()
