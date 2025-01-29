extends StaticBody2D

@export var needs = [true, true, true, true, true]

var has = [false, false, false, false, false]

var level_finished = false


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
	if (body.name == "Bubble_1"):
		has[0] = true
	elif (body.name == "Bubble_2"):
		has[1] = true
	elif (body.name == "Bubble_3"):
		has[2] = true
	elif (body.name == "Bubble_4"):
		has[3] = true
	elif (body.name == "Bubble_5"):
		has[4] = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if (body.name == "Bubble_1"):
		has[0] = false
	elif (body.name == "Bubble_2"):
		has[1] = false
	elif (body.name == "Bubble_3"):
		has[2] = false
	elif (body.name == "Bubble_4"):
		has[3] = false
	elif (body.name == "Bubble_5"):
		has[4] = false
