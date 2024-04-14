extends Area2D

@export var max_speed:float
@export var direction:Vector2
@export var points_range:Vector2

var speed:float
var points:int
var is_trash:bool

func _ready():
	points = randomize_points(points_range)
	speed = max_speed

func _physics_process(delta):
	position += direction * speed * delta
	
func randomize_points(p:Vector2) ->float:
	var final_points = randi_range(p.x,p.y)
	
	return final_points

func get_points() -> float:
	return points


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
