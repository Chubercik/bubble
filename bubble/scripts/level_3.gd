extends Node2D

@onready var bubble_1: CharacterBody2D = $Bubble_1
@onready var bubble_2: CharacterBody2D = $Bubble_2
@onready var bubble_3: CharacterBody2D = $Bubble_3
@onready var active_bubble: CharacterBody2D

@onready var camera: Camera2D = $Camera2D
@onready var cup: StaticBody2D = $Cup

@onready var ice_cube: Area2D = $IceCube
@onready var syrup: Area2D = $Syrup

@onready var lvl_comp: Control = $LvlCompleteScreen

@onready var spikes_1: TileMapLayer = $Level_3_tiled/Tiles_1
@onready var spikes_2: TileMapLayer = $Level_3_tiled/Tiles_2

@onready var active_spikes: Node2D = $ActiveSpikes
var spikes_y: float

@onready var button_1: Node2D = $Buttons/Button_1
@onready var button_2: Node2D = $Buttons/Button_2
@onready var button_3: Node2D = $Buttons/Button_3

@onready var platform_1: Node2D = $Platforms/Platform_1
@onready var platform_2: Node2D = $Platforms/Platform_2
var platform_1_y: float
var platform_2_y: float

var active_pos_x: float

@onready var bubble_indicator: Sprite2D = $Level_3_tiled/BubbleIndicator


func _ready() -> void:
	lvl_comp.curr_scene = 3

	spikes_y = active_spikes.position.y

	platform_1_y = platform_1.position.y
	platform_2_y = platform_2.position.y

	bubble_1.active = true
	active_bubble = bubble_1

	bubble_indicator.modulate = Color.html("#8350b0")


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
		bubble_indicator.modulate = Color.html("#8350b0")
	elif Input.is_key_pressed(KEY_2):
		bubble_1.active = false
		bubble_2.active = true
		bubble_3.active = false
		active_bubble = bubble_2
		bubble_indicator.modulate = Color.html("#00cdc3")
	elif Input.is_key_pressed(KEY_3):
		bubble_1.active = false
		bubble_2.active = false
		bubble_3.active = true
		active_bubble = bubble_3
		bubble_indicator.modulate = Color.html("#3b29cc")

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
