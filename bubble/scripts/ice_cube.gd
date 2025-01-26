extends Area2D

var animated_sprite: AnimatedSprite2D


func _ready() -> void:
	animated_sprite = $AnimatedSprite2D
	animated_sprite.play("default")
