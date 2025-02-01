extends Fluid2D

const NEW_DROPLET_TIMER: float = 0.1

var timer: float = 0.0


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if timer > NEW_DROPLET_TIMER:
		var new_points = points
		new_points.append(Vector2(0, -100))
		points = new_points
		timer = 0.0
	else:
		timer += delta
