extends Node2D

@export var CUTOFF: int = 800

@onready var sprite: Sprite2D = $Sprite2D
var copy: Sprite2D
var timer: float = 0.0


func _ready() -> void:
	sprite.set_meta("rot_dir", 45)
	copy = sprite.duplicate()


func _process(delta: float) -> void:
	if timer > 2.0:
		var new: Sprite2D = copy.duplicate()
		add_child(new)
		timer = 0.0
	for child in get_children():
		if child.position.y > CUTOFF:
			remove_child(child)
		else:
			child.position.y += 30 * delta
			if child.rotation_degrees > 45:
				child.set_meta("rot_dir", -45)
			elif child.rotation_degrees < -45:
				child.set_meta("rot_dir", 45)
			child.rotation_degrees += child.get_meta("rot_dir") * delta
	timer += delta
