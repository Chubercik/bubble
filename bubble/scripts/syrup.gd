extends Area2D

var animated_sprite: AnimatedSprite2D
var collected = false


func _ready() -> void:
	animated_sprite = $AnimatedSprite2D
	animated_sprite.play("default")


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		collected = true
		self.hide()
