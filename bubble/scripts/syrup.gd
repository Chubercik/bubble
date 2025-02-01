extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
var collected = false


func _ready() -> void:
	animated_sprite.play("default")


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if not collected:
			audio.play()
		collected = true
		self.hide()
