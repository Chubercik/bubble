extends Node2D

var lvl_comp: Control


func _ready() -> void:
	lvl_comp = $LvlCompleteScreen
	lvl_comp.curr_scene = 3


func _process(delta: float) -> void:
	# Quit level.
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

	# Restart level.
	if Input.is_key_pressed(KEY_R):
		get_tree().change_scene_to_file("res://scenes/level_3.tscn")
