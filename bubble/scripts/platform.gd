extends Node2D

enum Variants {NORMAL, HEAVY}
@export var PlatformVariant = Variants.NORMAL

var platform: Sprite2D
var platform_heavy: Sprite2D


func _ready() -> void:
	platform = $StaticBody2D/Platform
	platform_heavy = $StaticBody2D/Platform_Heavy


func _process(delta: float) -> void:
	match PlatformVariant:
		Variants.NORMAL:
			platform.show()
			platform_heavy.hide()
		Variants.HEAVY:
			platform.hide()
			platform_heavy.show()
