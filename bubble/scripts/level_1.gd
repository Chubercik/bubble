extends Node2D

var bubble_1: CharacterBody2D
var bubble_2: CharacterBody2D
var bubble_3: CharacterBody2D
var bubble_4: CharacterBody2D
var bubble_5: CharacterBody2D
var camera: Camera2D


func _ready() -> void:
	bubble_1 = $Bubble_1
	bubble_2 = $Bubble_2
	bubble_3 = $Bubble_3
	bubble_4 = $Bubble_4
	bubble_5 = $Bubble_5
	camera = $Camera2D

	bubble_1.active = true
	camera.reparent(bubble_1, false)


func _process(delta: float) -> void:
	# Quit level.
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

	if Input.is_key_pressed(KEY_Z):
		camera.zoom = Vector2(4, 4)

	if Input.is_key_pressed(KEY_X):
		camera.zoom = Vector2(1.2, 1.2)

	# Switch between bubbles.
	if Input.is_key_pressed(KEY_1):
		bubble_1.active = true
		bubble_2.active = false
		bubble_3.active = false
		bubble_4.active = false
		bubble_5.active = false
		camera.reparent(bubble_1, false)
	elif Input.is_key_pressed(KEY_2):
		bubble_1.active = false
		bubble_2.active = true
		bubble_3.active = false
		bubble_4.active = false
		bubble_5.active = false
		camera.reparent(bubble_2, false)
	elif Input.is_key_pressed(KEY_3):
		bubble_1.active = false
		bubble_2.active = false
		bubble_3.active = true
		bubble_4.active = false
		bubble_5.active = false
		camera.reparent(bubble_3, false)
	elif Input.is_key_pressed(KEY_4):
		bubble_1.active = false
		bubble_2.active = false
		bubble_3.active = false
		bubble_4.active = true
		bubble_5.active = false
		camera.reparent(bubble_4, false)
	elif Input.is_key_pressed(KEY_5):
		bubble_1.active = false
		bubble_2.active = false
		bubble_3.active = false
		bubble_4.active = false
		bubble_5.active = true
		camera.reparent(bubble_5, false)
