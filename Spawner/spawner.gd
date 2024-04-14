extends Node2D


@export var food_scene: PackedScene
@export var max_spawnrate:float
@export var spawn_rate_amount:float
@export var lvl_up:int
@export var spawn_offset:float
@export var food_container:Node2D

var spawnrate:float
var spawned_foods:int
var spawn_range:Vector2

@onready var timer = $Timer

func _ready():
	if food_scene == null:
		print("nothing to spawn")
		return
	
	spawnrate = max_spawnrate
	spawned_foods = 1
	spawn_range = Vector2(spawn_offset, get_viewport_rect().size.x - spawn_offset)
		
		
func _physics_process(delta):
	spawnrate = clamp(spawnrate,0,max_spawnrate)

func change_spawnrate() ->void:
	if spawnrate >0.2:
		spawnrate -= spawn_rate_amount
		print("spawnrate changed", spawnrate)

func get_spawnpoint(range:Vector2) ->float:
	var point = randf_range(range.x, range.y)
	return point

func spawn_food() ->void:
	var food_instance = food_scene.instantiate() as Node2D
	var spawn_point = get_spawnpoint(spawn_range)
	food_instance.global_position = Vector2(spawn_point,global_position.y)
	if food_container == null:
		print("nowhere to spawn")
		return
	food_container.add_child(food_instance)
	spawned_foods +=1
	


func _on_timer_timeout():
	timer.wait_time = spawnrate
	spawn_food()
	if spawned_foods % lvl_up == 0:
		change_spawnrate()
