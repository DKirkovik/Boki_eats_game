extends CharacterBody2D


@export var max_speed:float
@export var max_hp:int
@export var offset:float
@export var song: AudioStream

var speed:float
var hp:int
var screen_w
var is_dead:bool = false

@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var audio_stream_burgir = $AudioStreamBurgir
@onready var audio_steram_kapi = $AudioSteramKapi

func _ready():
	speed = max_speed
	hp = max_hp
	screen_w = get_viewport_rect().size.x
	GameManager.set_lives(hp)
	GameManager.game_over.connect(on_game_over)
	GameManager.is_game_over = false
	

func _physics_process(delta):
	
	var direction = Input.get_axis("left","right")
	
	position.x = clamp(position.x,offset,screen_w-offset)
	
	velocity.x = speed * direction
	
	move_and_slide()


func _on_hit_box_area_entered(area):
	if area.is_in_group("powerups"):
		if area.is_kapi:
			GameManager.on_lives_changed(1)
			audio_steram_kapi.play()
		else:
			GameManager.jelly_powerup.emit()
			audio_stream_player_2d.play()
		area.queue_free()
		
	if area.has_method("get_points"):
		GameManager.on_score_changed(area.get_points())
		if !is_dead:
			area.queue_free()
			if area.is_in_group("Burgir"):
				audio_stream_burgir.play()
			else:
				audio_stream_player_2d.play()

func on_game_over() ->void:
	is_dead = true
	set_physics_process(false)
	print("dead")
	self.hide()
