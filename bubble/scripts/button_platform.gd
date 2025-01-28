extends Node2D

enum Variants {NORMAL, ALT, HEAVY}
@export var ButtonVariant = Variants.NORMAL

var has_bubble_1 = false
var has_bubble_2 = false
var has_bubble_3 = false
var has_bubble_4 = false
var has_bubble_5 = false

var top: Sprite2D
var bottom: Sprite2D
var top_alt: Sprite2D
var bottom_alt: Sprite2D
var top_heavy: Sprite2D
var bottom_heavy: Sprite2D

var top_pos: Vector2
var bot_pos: Vector2


func _ready() -> void:
	top = $Area2D/Top
	top_alt = $Area2D/TopAlt
	top_heavy = $Area2D/TopHeavy
	bottom = $StaticBody2D/Bottom
	bottom_alt = $StaticBody2D/BottomAlt
	bottom_heavy = $StaticBody2D/BottomHeavy

	top_pos = top.position
	bot_pos = Vector2(top_pos.x, top_pos.y + 4)


func _process(_delta: float) -> void:
	match ButtonVariant:
		Variants.NORMAL:
			top.show()
			bottom.show()
			top_alt.hide()
			bottom_alt.hide()
			top_heavy.hide()
			bottom_heavy.hide()
		Variants.ALT:
			top.hide()
			bottom.hide()
			top_alt.show()
			bottom_alt.show()
			top_heavy.hide()
			bottom_heavy.hide()
		Variants.HEAVY:
			top.hide()
			bottom.hide()
			top_alt.hide()
			bottom_alt.hide()
			top_heavy.show()
			bottom_heavy.show()

	if ButtonVariant == Variants.HEAVY:
		if has_bubble_5:
			top.position = bot_pos
			top_alt.position = bot_pos
			top_heavy.position = bot_pos
	elif has_bubble_1 or has_bubble_2 or has_bubble_3 or has_bubble_4 or has_bubble_5:
		top.position = bot_pos
		top_alt.position = bot_pos
		top_heavy.position = bot_pos
	else:
		top.position = top_pos
		top_alt.position = top_pos
		bottom_heavy.position = top_pos


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
