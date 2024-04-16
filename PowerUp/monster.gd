extends Area2D

@export var max_speed:float
@export var direction:Vector2

var speed:float

func _ready():
	speed = max_speed

func _physics_process(delta):
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func bounce_back(force:float) ->void:
	position.y += -direction.y * force
