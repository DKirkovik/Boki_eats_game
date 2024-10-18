extends Control

@onready var label = $MarginContainer/Label
@onready var lives_label = $VBoxContainer/lives
@onready var animation_player = $AnimationPlayer
@onready var game_music = $GameMusic
@onready var timer: Timer = $Timer

var can_pause : bool = false

func _ready():
	hide()
	GameManager.game_start.connect(start_game)
	GameManager.score_changed.connect(update_lable)
	GameManager.lives_changed.connect(update_lives)
	GameManager.mute_audio.connect(mute_music)
	GameManager.game_over.connect(_on_game_over)
	GameManager.speed_powerup.connect(change_music_speed)
	GameManager.reset_score()
	update_lives(GameManager.get_lives())
	game_music.play()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") && can_pause:
		GameManager.game_paused.emit()

func mute_music() ->void:
	if game_music.playing:
		game_music.stop()
	else:
		game_music.play()

func update_lable(_score:float)->void:
	label.text = str(_score)
	animation_player.stop()
	animation_player.play("bounce")

func update_lives(_lives:int) ->void:
	lives_label.text = str(_lives)
	animation_player.stop()
	animation_player.play("idle")

func start_game() ->void:
	show()
	can_pause = true

func _on_game_over() ->void:
	can_pause = false

func change_music_speed(speed:float,_time:float) ->void:
	game_music.pitch_scale = 1.2
	timer.wait_time = _time
	timer.start()

func _on_timer_timeout() -> void:
	game_music.pitch_scale = 1
