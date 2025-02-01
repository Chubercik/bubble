extends Node2D

var dead: bool = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		dead = true
