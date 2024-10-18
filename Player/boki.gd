extends CharacterBody2D

##Max movment speed
@export var max_speed:float
##Max player HP
@export var max_hp:int
##Screen clamp offset
@export var offset:float
##Main menu song
@export var song: AudioStream
##Eating food particles
@export var food_particles : PackedScene
##Colors for slowed, and speed up
@export var color_slowed: Color
@export var color_fast: Color
##Time for speed, and slow buff
@export var slowed_time: float
@export var fast_time: float

var speed:float
var hp:int
var screen_w
var is_dead:bool = false
var is_slowed: bool = false
var is_fast: bool = false

@onready var animation_player = $AnimationPlayer
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var audio_stream_burgir = $AudioStreamBurgir
@onready var audio_blee = $AudioBlee
@onready var marker_2d = $Marker2D
@onready var debuff = $Debuff
@onready var take_dmg_audio: AudioStreamPlayer2D = $TakeDmg
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var shader = sprite_2d.material


func _ready():
	shader.set_shader_parameter("is_active",false)
	animation_player.play("RESET")
	speed = max_speed
	hp = max_hp
	screen_w = get_viewport_rect().size.x
	GameManager.set_lives(hp)
	GameManager.game_over.connect(on_game_over)
	GameManager.is_game_over = false
	GameManager.game_start.connect(start_game)
	GameManager.life_lost.connect(take_dmg)
	GameManager.speed_powerup.connect(change_speed)

func _physics_process(delta):
	
	if is_slowed:
		is_fast = false
		sprite_2d.modulate = color_slowed
		print("i changed color to slowed")
		
		
	if is_fast:
		is_slowed = false
		sprite_2d.modulate = color_fast
		print("i changed color to fast")
		
		
	
	var direction = Input.get_axis("left","right")
	
	position.x = clamp(position.x,offset,screen_w-offset)
	
	velocity.x = speed * direction
	
	move_and_slide()


func _on_hit_box_area_entered(area):
	if area.has_method("start_powerup"):
		area.start_powerup()
		animation_player.stop()
		animation_player.play("power_up")
		#change_speed(max_speed*2,fast_time)
		
	if area.has_method("get_points"):
		GameManager.on_score_changed(area.get_points())
		if !is_dead:
			spawn_particles()
			area.queue_free()
			if area.is_trash && !area.has_method("start_powerup"):
				GameManager.on_lives_changed(-1,true)
				change_speed(0.5,slowed_time)
				return
			if area.is_in_group("Burgir"):
				audio_stream_burgir.play()
			else:
				audio_stream_player_2d.play()
			animation_player.stop()
			animation_player.play("eat")

func on_game_over() ->void:
	is_dead = true
	set_physics_process(false)
	self.hide()


func spawn_particles() ->void:
	if food_particles !=null:
		var parctile_instance = food_particles.instantiate() as Node2D
		parctile_instance.global_position = marker_2d.global_position
		get_parent().add_child(parctile_instance)
	

func take_dmg(is_trash:bool) ->void:
	animation_player.stop()
	if !is_trash:
		take_dmg_audio.play()
	else:
		audio_blee.play()
	animation_player.stop()
	animation_player.play("take_dmg")


func change_speed(_speed_mult:float,_time) ->void:
	speed = speed * _speed_mult
	speed_color()
	debuff.wait_time = _time
	debuff.start()



func _on_debuff_timeout():
	print("debuf ended")
	speed = max_speed
	speed_color()
	shader.set_shader_parameter("is_active",false)
	is_slowed = false
	is_fast = false
	sprite_2d.modulate = Color.WHITE

func start_game() ->void:
	set_physics_process(true)

func speed_color() ->void:
	if speed > max_speed:
		print("is speed")
		is_fast = true
		shader.set_shader_parameter("is_active",true)
		
	if speed < max_speed:
		print("is slow")
		is_slowed = true
		shader.set_shader_parameter("is_active",false)
	
