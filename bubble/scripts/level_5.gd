extends Node2D

@onready var bubble_2: CharacterBody2D = $Bubble_2
@onready var bubble_4: CharacterBody2D = $Bubble_4
@onready var bubble_5: CharacterBody2D = $Bubble_5
var active_bubble: CharacterBody2D

@onready var camera: Camera2D = $Camera2D
@onready var cup: StaticBody2D = $Cup
var active_pos_y: float

@onready var ice_cube: Area2D = $IceCube
@onready var syrup: Area2D = $Syrup

@onready var spikes: TileMapLayer = $Level_5_tiled/Spikes
@onready var button: Node2D = $Button
@onready var platform: Node2D = $Platform
var platform_y: float

@onready var lvl_comp: Control = $LvlCompleteScreen


func _ready() -> void:
	platform_y = platform.position.y

	lvl_comp.curr_scene = 5

	bubble_2.active = true
	active_bubble = bubble_2


func _process(delta: float) -> void:
	# Quit level.
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

	# Restart level.
	if Input.is_key_pressed(KEY_R):
		get_tree().change_scene_to_file("res://scenes/level_5.tscn")

	# Switch between bubbles.
	if Input.is_key_pressed(KEY_2):
		bubble_2.active = true
		bubble_4.active = false
		bubble_5.active = false
		active_bubble = bubble_2
	elif Input.is_key_pressed(KEY_4):
		bubble_2.active = false
		bubble_4.active = true
		bubble_5.active = false
		active_bubble = bubble_4
	elif Input.is_key_pressed(KEY_5):
		bubble_2.active = false
		bubble_4.active = false
		bubble_5.active = true
		active_bubble = bubble_5

	# Update active position
	if not cup.level_finished:
		active_pos_y = active_bubble.position.y

	# Move camera to current bubble
	camera.position = Vector2(0, min(100, max(-100, active_pos_y)))

	var all_spikes = spikes.get_children()
	for spike in all_spikes:
		if spike.dead:
			var tree = get_tree()  # This can be `null` for some reason
			if tree:  # Ensure it's not
				tree.change_scene_to_file("res://scenes/level_5.tscn")

	if button.is_active():
		platform.position.y = move_toward(platform.position.y, 368, 50 * delta)
	else:
		platform.position.y = move_toward(platform.position.y, platform_y, 50 * delta)

	if cup.level_finished:
		var score = 1
		if ice_cube.collected:
			score += 1
		if syrup.collected:
			score += 1
		lvl_comp.score = score

		active_pos_y = 0
