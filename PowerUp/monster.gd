extends Area2D

## Max move speed
@export var max_speed:float
## Move direction
@export var direction:Vector2
##Is other powerup
@export var is_kapi:bool  #Make Enum for diff powerups
##Is trash
@export var is_trash:bool
## Amount of lives to give
@export var lives_amount:int
## Time powerup lasts
@export var powerup_time:float
##SFX 
@export var sfx:PackedScene

var speed:float

func _ready():
	is_trash = false
	speed = max_speed

func _physics_process(delta):
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func bounce_back(force:float) ->void:
	position.y += -direction.y * force

func start_powerup() ->void:
	
	#can be made with match stat for dif powerups
	#redef powerup code
	
	if is_kapi:
		GameManager.one_up(lives_amount)
	else:
		GameManager.jelly_powerup.emit(powerup_time)
	spawn_sound()
	spawn_particles()
	call_deferred("queue_free")
	
func spawn_sound() ->void:
	var sfx_instance = sfx.instantiate() as Node2D
	sfx_instance.global_position = global_position
	get_parent().add_child(sfx_instance)
	
func spawn_particles() ->void:
	pass
