extends Node

const TIP_LOC = Vector2(11, 6)

var cursor = load("res://sprites/cursor.png")
var cursor_click = load("res://sprites/cursor_click.png")


func _ready() -> void:
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, TIP_LOC)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("clicked"):
		Input.set_custom_mouse_cursor(cursor_click, Input.CURSOR_ARROW, TIP_LOC)
	elif Input.is_action_just_released("clicked"):
		Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, TIP_LOC)
