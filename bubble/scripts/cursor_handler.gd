extends Node

const TIP_LOC = Vector2(11, 6)

var cursor = load("res://sprites/cursor.png")
var cursor_click = load("res://sprites/cursor_click.png")


func _ready():
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, TIP_LOC)


func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Input.set_custom_mouse_cursor(cursor_click, Input.CURSOR_ARROW, TIP_LOC)
	else:
		Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, TIP_LOC)
