extends Area2D

@export var max_speed:Vector2
@export var direction:Vector2
@export var points_range:Vector2
@export var is_trash:bool

var speed:float
var points:int


func _ready():
	points = randomize_points(points_range)
	speed = randomize_speed(max_speed)

func _physics_process(delta):
	position += direction * speed * delta
	
func randomize_points(p:Vector2) ->float:
	var final_points = randi_range(p.x,p.y)
	
	return final_points

func randomize_speed(s:Vector2) ->float:
	var final_speed = randf_range(s.x,s.y)
	return final_speed

func get_points() -> float:
	if is_trash:
		return -points
	else:
		return points


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func bounce_back(force:float) ->void:
	position.y += -direction.y * force
