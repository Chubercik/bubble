extends Node2D

var anim_sprite: AnimatedSprite2D

var inside: Dictionary
var broken: bool

var timer = 0.0
var break_time = 0.0


func _ready() -> void:
	anim_sprite = $StaticBody2D/AnimatedSprite2D
	anim_sprite.play("default")
	inside = {}
	broken = false


func _process(delta: float) -> void:
	if len(inside) > 0:
		for thing in inside:
			if thing is CharacterBody2D and thing.is_on_floor():
				anim_sprite.play("crack")
				inside.erase(thing)
				broken = true
			else:
				break_time = timer
	elif not broken:
		break_time = timer
	if timer - break_time > 0.3:
		queue_free()
	timer += delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name != "Bubble_4" and body is not StaticBody2D:
		inside[body] = null


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name != "Bubble_4" and body is not StaticBody2D:
		inside.erase(body)
