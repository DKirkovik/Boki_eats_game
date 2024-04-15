extends Control

@onready var label = $MarginContainer/Label
@onready var lives_label = $MarginContainer/lives


func _ready():
	GameManager.score_changed.connect(update_lable)
	GameManager.lives_changed.connect(update_lives)
	update_lable(0)
	update_lives(GameManager.get_lives())



func update_lable(_score:float)->void:
	label.text = str(_score)

func update_lives(_lives:int) ->void:
	lives_label.text = str(_lives)
