extends Control

@onready var label = $MarginContainer/Label
@onready var lives_label = $VBoxContainer/lives
@onready var animation_player = $AnimationPlayer
@onready var game_music = $GameMusic


func _ready():
	GameManager.score_changed.connect(update_lable)
	GameManager.lives_changed.connect(update_lives)
	GameManager.mute_audio.connect(mute_music)
	update_lable(0)
	update_lives(GameManager.get_lives())
	game_music.play()

func mute_music() ->void:
	if game_music.playing:
		game_music.stop()
	else:
		game_music.play()
	

func update_lable(_score:float)->void:
	label.text = str(_score)
	animation_player.play("bounce")

func update_lives(_lives:int) ->void:
	lives_label.text = str(_lives)
	animation_player.play("idle")
