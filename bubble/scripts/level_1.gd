extends Node2D

var bubble_1: CharacterBody2D
var bubble_2: CharacterBody2D


func _ready() -> void:
	bubble_1 = $Bubble_1
	bubble_2 = $Bubble_2

	bubble_1.active = true


func _process(delta: float) -> void:
	# Quit level.
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

	# Switch between bubbles.
	if Input.is_key_pressed(KEY_1):
		bubble_1.active = true
		bubble_2.active = false
	elif Input.is_key_pressed(KEY_2):
		bubble_1.active = false
		bubble_2.active = true
