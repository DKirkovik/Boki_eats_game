extends CharacterBody2D


@export var max_speed:float
@export var max_hp:int
@export var offset:float
@export var song: AudioStream

var speed:float
var hp:int
var screen_w

@onready var audio_stream_player_2d = $AudioStreamPlayer2D

func _ready():
	speed = max_speed
	hp = max_hp
	screen_w = get_viewport_rect().size.x
	

func _physics_process(delta):
	
	var direction = Input.get_axis("left","right")
	
	position.x = clamp(position.x,offset,screen_w-offset)
	
	velocity.x = speed * direction
	
	move_and_slide()


func _on_hit_box_area_entered(area):
	if area.has_method("get_points"):
		GameManager.on_score_changed(area.get_points())
		area.queue_free()
		audio_stream_player_2d.play()

