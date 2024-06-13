extends MarginContainer

@onready var label_name = $Name
@onready var label_score = $Score



func set_params(score_name,score_score) ->void:
	label_name.text = str(score_name)
	label_score.text = str(score_score)
