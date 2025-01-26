extends Node2D

var cup: StaticBody2D
var bubble_1: CharacterBody2D
var bubble_2: CharacterBody2D
var ice_cube: Area2D
var tip_1: AnimatedSprite2D
var tip_2: AnimatedSprite2D
var control_1_2_4: AnimatedSprite2D
var control_3: AnimatedSprite2D
var goal: AnimatedSprite2D
var bubble_indicator: Sprite2D


func _ready() -> void:
	cup = $Cup
	bubble_1 = $Bubble_1
	bubble_2 = $Bubble_2
	ice_cube = $IceCube
	tip_1 = $"Pop-ups/Tip_1"
	tip_2 = $"Pop-ups/Tip_2"
	control_1_2_4 = $"Pop-ups/Controls_1_2_4"
	control_3 = $"Pop-ups/Controls_3"
	goal = $"Pop-ups/Goal"
	bubble_indicator = $Level_1_tiled/BubbleIndicator

	bubble_1.active = true
	tip_1.play("default")
	tip_2.play("default")
	control_1_2_4.play("default")
	control_3.play("default")
	goal.play("default")
	bubble_indicator.modulate = Color.html("#8350b0")


func _process(delta: float) -> void:
	# Quit level.
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

	# Restart level.
	if Input.is_key_pressed(KEY_R):
		get_tree().change_scene_to_file("res://scenes/level_1.tscn")

	# Switch between bubbles.
	if Input.is_key_pressed(KEY_1):
		bubble_1.active = true
		bubble_2.active = false
		bubble_indicator.modulate = Color.html("#8350b0")
	elif Input.is_key_pressed(KEY_2):
		bubble_1.active = false
		bubble_2.active = true
		bubble_indicator.modulate = Color.html("#00cdc3")

	if cup.level_finished:
		print("Hurra!")


func _on_tip_1_close_pressed() -> void:
	tip_1.hide()


func _on_tip_2_close_pressed() -> void:
	tip_2.hide()


func _on_controls_1_2_4_close_pressed() -> void:
	control_1_2_4.hide()


func _on_controls_3_close_pressed() -> void:
	control_3.hide()


func _on_goal_close_pressed() -> void:
	goal.hide()
