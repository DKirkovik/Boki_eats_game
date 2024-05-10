extends Control

@onready var timer = $Timer
@onready var progress_bar = $ColorRect/CenterContainer/VBoxContainer/ProgressBar
@onready var animation_player = $AnimationPlayer

@export var obj_to_load: Array
var obj_to_delete:Array

func _ready():
	show()
	loead_shaders()
	
func _process(delta):
	progress_bar.value = 100 - (timer.time_left /timer.wait_time) * 100


func loead_shaders() ->void:
	if obj_to_load != null:
		for obj in obj_to_load:
			var obj_instance = obj.instantiate() as Node2D
			obj_instance.set_physics_process(false)
			obj_instance.z_index = -1
			call_deferred("add_child",obj_instance)
			print("child added",obj_instance)
			obj_to_delete.append(obj_instance)


func _on_timer_timeout():
	for obj in obj_to_delete:
		if obj != null:
			obj.call_deferred("queue_free")
	animation_player.play("fade_out")
	GameManager.game_start.emit()
