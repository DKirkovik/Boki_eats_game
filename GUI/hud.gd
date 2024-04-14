extends Control

@onready var label = $MarginContainer/Label


func _ready():
	GameManager.score_changed.connect(update_lable)
	update_lable(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_lable(_score:float)->void:
	label.text = str(_score)
