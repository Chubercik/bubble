extends Area2D

var animated_sprite: AnimatedSprite2D
var audio: AudioStreamPlayer2D
var collected = false


func _ready() -> void:
	animated_sprite = $AnimatedSprite2D
	audio = $AudioStreamPlayer2D
	animated_sprite.play("default")


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if not collected:
			audio.play()
		collected = true
		self.hide()
