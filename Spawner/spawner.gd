extends Node2D


@export var food_scenes: Array
@export var powerup_scenes:Array
@export var max_spawnrate:float
@export var spawn_rate_amount:float
@export var lvl_up:int
@export var spawn_offset:float
@export var food_container:Node2D
@export var dif_level:float
@export var powerup_spawn_per:float


var spawnrate:float
var spawned_foods:int
var spawn_range:Vector2
var cur_powerup_spawn_per:float

@onready var timer = $Timer

func _ready():
	GameManager.game_over.connect(on_game_over)
	if food_scenes == null:
		print("nothing to spawn")
		return
	if powerup_scenes == null:
		print("no powerups to spawn")
		return
	
	spawnrate = max_spawnrate
	spawned_foods = 1
	spawn_range = Vector2(spawn_offset, get_viewport_rect().size.x - spawn_offset)
	cur_powerup_spawn_per = powerup_spawn_per
		

func change_spawnrate() ->void:
	if spawnrate > dif_level:
		spawnrate -= spawn_rate_amount
		print("spawnrate changed", spawnrate)
		timer.wait_time = spawnrate


func get_spawnpoint(range:Vector2) ->float:
	var point = randf_range(range.x, range.y)
	return point


func spawn_food() ->void:
	var num = randi_range(0,food_scenes.size()-1)
	var food_instance = food_scenes[num].instantiate() as Node2D
	var spawn_point = get_spawnpoint(spawn_range)
	food_instance.global_position = Vector2(spawn_point,global_position.y)
	if food_container == null:
		print("nowhere to spawn")
		return
	food_container.add_child(food_instance)
	spawned_foods +=1
	

func _on_timer_timeout():
	spawn_food()
	try_spawn_powerup()
	if spawned_foods % lvl_up == 0:
		change_spawnrate()
		spawn_powerup()


func on_game_over()->void:
	timer.stop()


func spawn_powerup() -> void:
	var num = randi_range(0,powerup_scenes.size()-1)
	var powerup_instance = powerup_scenes[num].instantiate() as Node2D
	var spawn_point = get_spawnpoint(spawn_range)
	powerup_instance.global_position = Vector2(spawn_point,global_position.y)
	if food_container == null:
		print("nowhere to spawn")
		return
	food_container.add_child(powerup_instance)


func try_spawn_powerup() ->void:
	var ran_num = randf_range(0,100)
	if ran_num <= cur_powerup_spawn_per:
		spawn_powerup()
		cur_powerup_spawn_per = 0
	else:
		cur_powerup_spawn_per += 1
		
