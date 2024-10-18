extends Area2D


##Bounc particles
@export var particles_scene: PackedScene
##Bouncing force
@export var bounce_force:float
##Time the powerup lasts
@export var powerup_time:float
##Offset at withc particles spawn
@export var particle_offset: float

@onready var bounce_area = $BounceArea
@onready var sprite_2d = $Sprite2D
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var timer = $Timer
@onready var start_timer = $StartTimer

var is_bounce:bool = false

func _ready():
	bounce_area.monitoring = false
	sprite_2d.hide()
	GameManager.jelly_powerup.connect(start_powerup)

func _on_area_entered(area):
	if area.has_method("get_points") && !is_bounce && !area.is_trash:
		GameManager.on_lives_changed(-1,false)
		
func activate_bounce() ->void:
	sprite_2d.show()
	bounce_area.monitoring = true
	timer.start()

func _on_timer_timeout():
	sprite_2d.hide()
	bounce_area.monitoring = false
	is_bounce = false

func _on_timer_2_timeout():
	is_bounce = true
	activate_bounce()


func _on_bounce_area_area_entered(area):
	if area.has_method("bounce_back") && !area.is_trash:
		audio_stream_player_2d.play()
		spawn_particles(area.global_position)
		area.bounce_back(bounce_force)

func start_powerup(_time) ->void:
	timer.wait_time = _time
	start_timer.start()

func spawn_particles(pos:Vector2) ->void:
	if particles_scene == null:
		print("nothing to spawn")
		return
	var particle_instnace = particles_scene.instantiate() as Node2D
	particle_instnace.global_position = Vector2(pos.x,pos.y + particle_offset)
	get_parent().add_child(particle_instnace)
