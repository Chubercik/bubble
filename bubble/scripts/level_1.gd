extends Node2D

@onready var cup: StaticBody2D = $Cup

@onready var bubble_1: CharacterBody2D = $Bubble_1
@onready var bubble_2: CharacterBody2D = $Bubble_2

@onready var ice_cube: Area2D = $IceCube
@onready var syrup: Area2D = $Syrup

@onready var tip_1: AnimatedSprite2D = $"Pop-ups/Tip_1"
@onready var tip_2: AnimatedSprite2D = $"Pop-ups/Tip_2"

@onready var control_1_2_4: AnimatedSprite2D = $"Pop-ups/Controls_1_2_4"
@onready var control_3: AnimatedSprite2D = $"Pop-ups/Controls_3"

@onready var goal: AnimatedSprite2D = $"Pop-ups/Goal"

@onready var bubble_indicator: Sprite2D = $Level_1_tiled/BubbleIndicator

@onready var lvl_comp: Control = $LvlCompleteScreen


func _ready() -> void:
	lvl_comp.curr_scene = 1

	bubble_1.active = true
	tip_1.play("default")
	tip_2.play("default")
	control_1_2_4.play("default")
	control_3.play("default")
	goal.play("default")
	bubble_indicator.modulate = Color.html("#8350b0")


func _process(_delta: float) -> void:
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
		var score = 1
		if ice_cube.collected:
			score += 1
		if syrup.collected:
			score += 1
		lvl_comp.score = score


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
