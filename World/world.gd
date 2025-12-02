extends Node

func _process(delta):
	
	if Input.is_action_just_pressed("restart"):
		pass
		
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("mute"):
		GameManager.mute_audio.emit()
