extends StaticBody2D

var has_bubble_1 = false
var has_bubble_2 = false
var level_finished = false


func _process(_delta: float) -> void:
	if has_bubble_1 and has_bubble_2:
		level_finished = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Bubble_1"):
		has_bubble_1 = true
	elif (body.name == "Bubble_2"):
		has_bubble_2 = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if (body.name == "Bubble_1"):
		has_bubble_1 = false
	elif (body.name == "Bubble_2"):
		has_bubble_2 = false
