extends Node2D

var has_bubble_1 = false
var has_bubble_2 = false
var has_bubble_3 = false
var has_bubble_4 = false
var has_bubble_5 = false

var top: Sprite2D
var top_pos: Vector2
var bot_pos: Vector2


func _ready() -> void:
	top = $Area2D/Top
	top_pos = top.position
	bot_pos = Vector2(top_pos.x, top_pos.y + 4)


func _process(_delta: float) -> void:
	if has_bubble_1 or has_bubble_2 or has_bubble_3 or has_bubble_4 or has_bubble_5:
		top.position = bot_pos
	else:
		top.position = top_pos


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Bubble_1"):
		has_bubble_1 = true
	elif (body.name == "Bubble_2"):
		has_bubble_2 = true
	elif (body.name == "Bubble_3"):
		has_bubble_3 = true
	elif (body.name == "Bubble_4"):
		has_bubble_4 = true
	elif (body.name == "Bubble_5"):
		has_bubble_5 = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if (body.name == "Bubble_1"):
		has_bubble_1 = false
	elif (body.name == "Bubble_2"):
		has_bubble_2 = false
	elif (body.name == "Bubble_3"):
		has_bubble_3 = false
	elif (body.name == "Bubble_4"):
		has_bubble_4 = false
	elif (body.name == "Bubble_5"):
		has_bubble_5 = false
