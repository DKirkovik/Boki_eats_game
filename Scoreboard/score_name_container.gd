extends MarginContainer

@onready var label_name = $Name
@onready var label_score = $Score
@onready var timer = $Timer

var score
var p_name

func set_params(score_name,score_score) ->void:
	p_name =  str(score_name)
	score = str(int(score_score))

func _on_timer_timeout():
	label_name.text = p_name
	label_score.text = score
