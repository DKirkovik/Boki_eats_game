extends Control

@onready var timer = $Timer
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var texture_rect = $MarginContainer/TextureRect


func _ready():
	GameManager.game_over.connect(on_game_over)


func on_game_over() ->void:
	timer.start()

func _on_timer_timeout():
	texture_rect.show()
	audio_stream_player_2d.play()
	
