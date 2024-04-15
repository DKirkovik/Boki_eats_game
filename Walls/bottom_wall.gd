extends Area2D

@onready var bounce_area = $BounceArea
@onready var sprite_2d = $Sprite2D



func _ready():
	bounce_area.monitoring = false
	sprite_2d.hide()


func _on_area_entered(area):
	if area.has_method("get_points"):
		GameManager.on_lives_changed(-1)
		print("area entered")
		
		
