extends Node2D

var anim_sprite: AnimatedSprite2D
var broken: bool

var timer = 0.0
var break_time = 0.0


func _ready() -> void:
	anim_sprite = $StaticBody2D/AnimatedSprite2D
	anim_sprite.play("default")
	broken = false


func _process(delta: float) -> void:
	if broken:
		anim_sprite.play("crack")
		if timer - break_time > 0.3:
			queue_free()
	else:
		break_time = timer
	timer += delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name != "Bubble_4":
		broken = true
