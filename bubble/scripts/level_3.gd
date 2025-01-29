extends Node2D

var bubble_1: CharacterBody2D
var bubble_2: CharacterBody2D
var bubble_3: CharacterBody2D
var active_bubble: CharacterBody2D

var camera: Camera2D
var cup: StaticBody2D

var ice_cube: Area2D
var syrup: Area2D

var lvl_comp: Control

var spikes_1: TileMapLayer
var spikes_2: TileMapLayer

var active_spikes: Node2D
var spikes_y: float

var button_1: Node2D
var button_2: Node2D
var button_3: Node2D

var platform_1: Node2D
var platform_2: Node2D
var platform_1_y: float
var platform_2_y: float

var active_pos_x: float


func _ready() -> void:
	bubble_1 = $Bubble_1
	bubble_2 = $Bubble_2
	bubble_3 = $Bubble_3

	camera = $Camera2D
	cup = $Cup

	ice_cube = $IceCube
	syrup = $Syrup

	lvl_comp = $LvlCompleteScreen
	lvl_comp.curr_scene = 3

	spikes_1 = $Level_3_tiled/Tiles_1
	spikes_2 = $Level_3_tiled/Tiles_2

	active_spikes = $ActiveSpikes
	spikes_y = active_spikes.position.y

	button_1 = $Buttons/Button_1
	button_2 = $Buttons/Button_2
	button_3 = $Buttons/Button_3

	platform_1 = $Platforms/Platform_1
	platform_2 = $Platforms/Platform_2
	platform_1_y = platform_1.position.y
	platform_2_y = platform_2.position.y

	bubble_1.active = true
	active_bubble = bubble_1


func _process(delta: float) -> void:
	# Quit level.
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

	# Restart level.
	if Input.is_key_pressed(KEY_R):
		get_tree().change_scene_to_file("res://scenes/level_3.tscn")

	# Switch between bubbles.
	if Input.is_key_pressed(KEY_1):
		bubble_1.active = true
		bubble_2.active = false
		bubble_3.active = false
		active_bubble = bubble_1
	elif Input.is_key_pressed(KEY_2):
		bubble_1.active = false
		bubble_2.active = true
		bubble_3.active = false
		active_bubble = bubble_2
	elif Input.is_key_pressed(KEY_3):
		bubble_1.active = false
		bubble_2.active = false
		bubble_3.active = true
		active_bubble = bubble_3

	# Update active position
	if not cup.level_finished:
		active_pos_x = active_bubble.position.x

	# Move camera to current bubble
	camera.position = Vector2(min(72, max(-72, active_pos_x)), 0)

	var all_spikes = spikes_1.get_children() + spikes_2.get_children() + active_spikes.get_children()
	for spike in all_spikes:
		if spike.dead:
			var tree = get_tree()  # This can be `null` for some reason
			if tree:  # Ensure it's not
				tree.change_scene_to_file("res://scenes/level_3.tscn")

	if button_1.is_active():
		platform_1.position.y = move_toward(platform_1.position.y, 90, 50 * delta)
	else:
		platform_1.position.y = move_toward(platform_1.position.y, platform_1_y, 50 * delta)

	if button_2.is_active():
		active_spikes.position.y = move_toward(active_spikes.position.y, spikes_y + 32, 50 * delta)
	else:
		active_spikes.position.y = move_toward(active_spikes.position.y, spikes_y, 50 * delta)

	if button_3.is_active():
		platform_2.position.y = move_toward(platform_2.position.y, -80, 50 * delta)
	else:
		platform_2.position.y = move_toward(platform_2.position.y, platform_2_y, 50 * delta)

	if cup.level_finished:
		var score = 1
		if ice_cube.collected:
			score += 1
		if syrup.collected:
			score += 1
		lvl_comp.score = score

		active_pos_x = 0
