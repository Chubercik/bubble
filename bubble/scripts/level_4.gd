extends Node2D

@onready var bubble_1: CharacterBody2D = $Bubble_1
@onready var bubble_2: CharacterBody2D = $Bubble_2
@onready var bubble_3: CharacterBody2D = $Bubble_3
@onready var bubble_4: CharacterBody2D = $Bubble_4
var active_bubble: CharacterBody2D

@onready var camera: Camera2D = $Camera2D
@onready var cup: StaticBody2D = $Cup
var active_pos_y: float

@onready var ice_cube: Area2D = $IceCube
@onready var syrup: Area2D = $Syrup

@onready var spikes_1: TileMapLayer = $Level_4_tiled/Spikes_1
@onready var active_spikes_1: Node2D = $ActiveSpikes_1
@onready var active_spikes_2: Node2D = $ActiveSpikes_2
@onready var active_spikes_3_up: Node2D = $ActiveSpikes_3/Up
@onready var active_spikes_3_left: Node2D = $ActiveSpikes_3/Left
@onready var active_spikes_3_right: Node2D = $ActiveSpikes_3/Right
var spikes_1_y: float
var spikes_2_y: float
var spikes_3_y: float
var spikes_3_x1: float
var spikes_3_x2: float

@onready var button_1: Node2D = $Buttons/ButtonPlatform_1
@onready var button_2: Node2D = $Buttons/ButtonPlatform_2
@onready var button_3: Node2D = $Buttons/ButtonPlatform_3
@onready var button_4: Node2D = $Buttons/ButtonPlatform_4

@onready var platform_1: Node2D = $Platforms/Platform_1
@onready var platform_2: Node2D = $Platforms/Platform_2
@onready var platform_3: Node2D = $Platforms/Platform_3
var platform_1_y: float
var platform_2_y: float
var platform_3_y: float

@onready var bubble_indicator: Sprite2D = $Level_4_tiled/BubbleIndicator

@onready var lvl_comp: Control = $LvlCompleteScreen


func _ready() -> void:
	active_pos_y = 0.0

	spikes_1_y = active_spikes_1.position.y
	spikes_2_y = active_spikes_2.position.y
	spikes_3_y = active_spikes_3_up.position.y
	spikes_3_x1 = active_spikes_3_left.position.x
	spikes_3_x2 = active_spikes_3_right.position.x

	platform_1_y = platform_1.position.y
	platform_2_y = platform_2.position.y
	platform_3_y = platform_3.position.y

	lvl_comp.curr_scene = 4

	bubble_1.active = true
	active_bubble = bubble_1

	bubble_indicator.modulate = Color.html("#8350b0")


func _process(delta: float) -> void:
	# Quit level.
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

	# Restart level.
	if Input.is_key_pressed(KEY_R):
		get_tree().change_scene_to_file("res://scenes/level_4.tscn")

	# Switch between bubbles.
	if Input.is_key_pressed(KEY_1):
		bubble_1.active = true
		bubble_2.active = false
		bubble_3.active = false
		bubble_4.active = false
		active_bubble = bubble_1
		bubble_indicator.modulate = Color.html("#8350b0")
	elif Input.is_key_pressed(KEY_2):
		bubble_1.active = false
		bubble_2.active = true
		bubble_3.active = false
		bubble_4.active = false
		active_bubble = bubble_2
		bubble_indicator.modulate = Color.html("#00cdc3")
	elif Input.is_key_pressed(KEY_3):
		bubble_1.active = false
		bubble_2.active = false
		bubble_3.active = true
		bubble_4.active = false
		active_bubble = bubble_3
		bubble_indicator.modulate = Color.html("#3b29cc")
	elif Input.is_key_pressed(KEY_4):
		bubble_1.active = false
		bubble_2.active = false
		bubble_3.active = false
		bubble_4.active = true
		active_bubble = bubble_4
		bubble_indicator.modulate = Color.html("#dff242")

	# Update active position
	if not cup.level_finished:
		active_pos_y = active_bubble.position.y

	# Move camera to current bubble
	camera.position = Vector2(0, min(20, max(-20, active_pos_y)))

	var all_spikes = spikes_1.get_children() + active_spikes_1.get_children() + active_spikes_2.get_children() + active_spikes_3_up.get_children() + active_spikes_3_left.get_children() + active_spikes_3_right.get_children()
	for spike in all_spikes:
		if spike.dead:
			var tree = get_tree()  # This can be `null` for some reason
			if tree:  # Ensure it's not
				tree.change_scene_to_file("res://scenes/level_4.tscn")

	if button_1.is_active():
		active_spikes_1.position.y = move_toward(active_spikes_1.position.y, spikes_1_y + 32, 50 * delta)
	else:
		active_spikes_1.position.y = move_toward(active_spikes_1.position.y, spikes_1_y, 50 * delta)

	if button_2.is_active():
		platform_1.position.y = move_toward(platform_1.position.y, 176, 50 * delta)
		platform_2.position.y = move_toward(platform_2.position.y, platform_3_y, 50 * delta)
		platform_3.position.y = move_toward(platform_3.position.y, platform_2_y, 50 * delta)
	else:
		platform_1.position.y = move_toward(platform_1.position.y, platform_1_y, 50 * delta)
		platform_2.position.y = move_toward(platform_2.position.y, platform_2_y, 50 * delta)
		platform_3.position.y = move_toward(platform_3.position.y, platform_3_y, 50 * delta)

	if button_3.is_active():
		active_spikes_2.position.y = move_toward(active_spikes_2.position.y, spikes_2_y + 32, 50 * delta)
	else:
		active_spikes_2.position.y = move_toward(active_spikes_2.position.y, spikes_2_y, 50 * delta)

	if button_4.is_active():
		active_spikes_3_up.position.y = move_toward(active_spikes_3_up.position.y, spikes_3_y + 32, 50 * delta)
		active_spikes_3_left.position.x = move_toward(active_spikes_3_left.position.x, spikes_3_x1 + 32, 50 * delta)
		active_spikes_3_right.position.x = move_toward(active_spikes_3_right.position.x, spikes_3_x2 - 32, 50 * delta)
	else:
		active_spikes_3_up.position.y = move_toward(active_spikes_3_up.position.y, spikes_3_y, 50 * delta)
		active_spikes_3_left.position.x = move_toward(active_spikes_3_left.position.x, spikes_3_x1, 50 * delta)
		active_spikes_3_right.position.x = move_toward(active_spikes_3_right.position.x, spikes_3_x2, 50 * delta)

	if cup.level_finished:
		var score = 1
		if ice_cube.collected:
			score += 1
		if syrup.collected:
			score += 1
		lvl_comp.score = score

		active_pos_y = 0
