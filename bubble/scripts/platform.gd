extends Node2D

enum Variants {NORMAL, HEAVY}
@export var PlatformVariant = Variants.NORMAL

@onready var platform: Sprite2D = $StaticBody2D/Platform
@onready var platform_heavy: Sprite2D = $StaticBody2D/Platform_Heavy


func _process(_delta: float) -> void:
	match PlatformVariant:
		Variants.NORMAL:
			platform.show()
			platform_heavy.hide()
		Variants.HEAVY:
			platform.hide()
			platform_heavy.show()
