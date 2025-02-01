extends StaticBody2D

@export var needs: Array[bool] = [true, true, true, true, true]

var has: Array[bool] = [false, false, false, false, false]

var level_finished: bool = false


func has_all_needs() -> bool:
	for i in range(5):
		if needs[i]:
			if not has[i]:
				return false
	return true


func _process(_delta: float) -> void:
	if has_all_needs():
		level_finished = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name.substr(0, 7) == "Bubble_"):
		has[int(body.name.substr(7)) - 1] = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if (body.name.substr(0, 7) == "Bubble_"):
		has[int(body.name.substr(7)) - 1] = false
