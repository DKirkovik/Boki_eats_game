extends CharacterBody2D

@export var max_speed:float
@export var max_hp:int
@export var offset:float
@export var song: AudioStream
@export var food_particles : PackedScene

var speed:float
var hp:int
var screen_w
var is_dead:bool = false

@onready var animation_player = $AnimationPlayer
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var audio_stream_burgir = $AudioStreamBurgir
@onready var audio_blee = $AudioBlee
@onready var marker_2d = $Marker2D


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
	if area.has_method("start_powerup"):
		area.start_powerup()
		animation_player.play("power_up")
		
	if area.has_method("get_points"):
		GameManager.on_score_changed(area.get_points())
		if !is_dead:
			spawn_particles()
			area.queue_free()
			if area.is_trash:
				GameManager.on_lives_changed(-1)
				take_dmg()
				audio_blee.play()
				return
			if area.is_in_group("Burgir"):
				audio_stream_burgir.play()
			else:
				audio_stream_player_2d.play()
			if !animation_player.is_playing():
				animation_player.play("eat")

func on_game_over() ->void:
	is_dead = true
	set_physics_process(false)
	print("dead")
	self.hide()


func spawn_particles() ->void:
	if food_particles !=null:
		var parctile_instance = food_particles.instantiate() as Node2D
		parctile_instance.global_position = marker_2d.global_position
		get_parent().add_child(parctile_instance)
	

func take_dmg() ->void:
	if !animation_player.is_playing():
		animation_player.play("take_dmg")
