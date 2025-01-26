extends Node2D

var cup: StaticBody2D
var bubble_1: CharacterBody2D
var bubble_2: CharacterBody2D
var bubble_3: CharacterBody2D
var bubble_4: CharacterBody2D
var bubble_5: CharacterBody2D
var ice_cube: Area2D
var syrup: Area2D
var camera: Camera2D

var lvl_comp: Control

var active_bubble: CharacterBody2D
var active_pos = Vector2(0, 0)


func _ready() -> void:
	cup = $Cup
	bubble_1 = $Bubble_1
	bubble_2 = $Bubble_2
	bubble_3 = $Bubble_3
	bubble_4 = $Bubble_4
	bubble_5 = $Bubble_5
	ice_cube = $IceCube
	syrup = $Syrup
	camera = $Camera2D

	lvl_comp = $LvlCompleteScreen
	lvl_comp.curr_scene = 6

	bubble_1.active = true
	active_bubble = bubble_1


func _process(delta: float) -> void:
	# Quit level.
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

	# Restart level.
	if Input.is_key_pressed(KEY_R):
		get_tree().change_scene_to_file("res://scenes/level_6.tscn")

	# Switch between bubbles.
	if Input.is_key_pressed(KEY_1):
		bubble_1.active = true
		bubble_2.active = false
		bubble_3.active = false
		bubble_4.active = false
		bubble_5.active = false
		active_bubble = bubble_1
	elif Input.is_key_pressed(KEY_2):
		bubble_1.active = false
		bubble_2.active = true
		bubble_3.active = false
		bubble_4.active = false
		bubble_5.active = false
		active_bubble = bubble_2
	elif Input.is_key_pressed(KEY_3):
		bubble_1.active = false
		bubble_2.active = false
		bubble_3.active = true
		bubble_4.active = false
		bubble_5.active = false
		active_bubble = bubble_3
	elif Input.is_key_pressed(KEY_4):
		bubble_1.active = false
		bubble_2.active = false
		bubble_3.active = false
		bubble_4.active = true
		bubble_5.active = false
		active_bubble = bubble_4
	elif Input.is_key_pressed(KEY_5):
		bubble_1.active = false
		bubble_2.active = false
		bubble_3.active = false
		bubble_4.active = false
		bubble_5.active = true
		active_bubble = bubble_5

	# Update active position
	active_pos = active_bubble.position

	# Move camera to current bubble
	camera.position = Vector2(min(232, max(-200, active_pos.x)), min(68, max(-68, active_pos.y)))

	if cup.level_finished:
		pass
