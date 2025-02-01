extends Node2D

@onready var cup: StaticBody2D = $Cup
@onready var bubble_1: CharacterBody2D = $Bubble_1
@onready var bubble_2: CharacterBody2D = $Bubble_2
@onready var bubble_3: CharacterBody2D = $Bubble_3
@onready var bubble_4: CharacterBody2D = $Bubble_4
@onready var bubble_5: CharacterBody2D = $Bubble_5
@onready var ice_cube: Area2D = $IceCube
@onready var syrup: Area2D = $Syrup
@onready var camera: Camera2D = $Camera2D

@onready var lvl_comp: Control = $LvlCompleteScreen

@onready var spikes_1: TileMapLayer = $Level_6_tiled/Tiles
@onready var spikes_2: TileMapLayer = $Level_6_tiled/Tiles_Rotated

@onready var active_spikes_1: Node2D = $ActiveSpikes_1
@onready var active_spikes_2: Node2D = $ActiveSpikes_2

var spikes_1_y: float
var spikes_2_y: float

@onready var button_1: Node2D = $Buttons/Button_1
@onready var button_2: Node2D = $Buttons/Button_2
@onready var button_3: Node2D = $Buttons/Button_3
@onready var button_4: Node2D = $Buttons/Button_4

@onready var platform_1: Node2D = $Platforms/Platform_1
@onready var platform_2: Node2D = $Platforms/Platform_2
@onready var platform_3: Node2D = $Platforms/Platform_3
@onready var platform_4: Node2D = $Platforms/Platform_4

var platform_1_y: float
var platform_2_y: float
var platform_3_y: float
var platform_4_y: float

var active_bubble: CharacterBody2D
var active_pos: Vector2 = Vector2(0, 0)

@onready var bubble_indicator: Panel = $Camera2D/BubbleIndicator
var bubble_indicator_style: StyleBox


func _ready() -> void:
	lvl_comp.curr_scene = 6

	spikes_1_y = active_spikes_1.position.y
	spikes_2_y = active_spikes_2.position.y

	platform_1_y = platform_1.position.y
	platform_2_y = platform_2.position.y
	platform_3_y = platform_3.position.y
	platform_4_y = platform_4.position.y

	bubble_1.active = true
	active_bubble = bubble_1

	bubble_indicator_style = bubble_indicator.get_theme_stylebox("panel")
	bubble_indicator_style.border_color = Color.html("#8350b0")


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
		bubble_indicator_style.border_color = Color.html("#8350b0")
	elif Input.is_key_pressed(KEY_2):
		bubble_1.active = false
		bubble_2.active = true
		bubble_3.active = false
		bubble_4.active = false
		bubble_5.active = false
		active_bubble = bubble_2
		bubble_indicator_style.border_color = Color.html("#00cdc3")
	elif Input.is_key_pressed(KEY_3):
		bubble_1.active = false
		bubble_2.active = false
		bubble_3.active = true
		bubble_4.active = false
		bubble_5.active = false
		active_bubble = bubble_3
		bubble_indicator_style.border_color = Color.html("#3b29cc")
	elif Input.is_key_pressed(KEY_4):
		bubble_1.active = false
		bubble_2.active = false
		bubble_3.active = false
		bubble_4.active = true
		bubble_5.active = false
		active_bubble = bubble_4
		bubble_indicator_style.border_color = Color.html("#dff242")
	elif Input.is_key_pressed(KEY_5):
		bubble_1.active = false
		bubble_2.active = false
		bubble_3.active = false
		bubble_4.active = false
		bubble_5.active = true
		active_bubble = bubble_5
		bubble_indicator_style.border_color = Color.html("#c83fbe")

	# Update active position
	if not cup.level_finished:
		active_pos = active_bubble.position

	# Move camera to current bubble
	camera.position = Vector2(min(232, max(-200, active_pos.x)), min(68, max(-68, active_pos.y)))

	var all_spikes = spikes_1.get_children() + spikes_2.get_children() + active_spikes_1.get_children() + active_spikes_2.get_children()
	for spike in all_spikes:
		if spike.dead:
			var tree = get_tree()  # This can be `null` for some reason
			if tree:  # Ensure it's not
				tree.change_scene_to_file("res://scenes/level_6.tscn")

	if button_1.is_active():
		platform_1.position.y = move_toward(platform_1.position.y, 64, 50 * delta)
		platform_2.position.y = move_toward(platform_2.position.y, -176, 50 * delta)
		platform_3.position.y = move_toward(platform_3.position.y, -304, 50 * delta)
	else:
		platform_1.position.y = move_toward(platform_1.position.y, platform_1_y, 50 * delta)
		platform_2.position.y = move_toward(platform_2.position.y, platform_2_y, 50 * delta)
		platform_3.position.y = move_toward(platform_3.position.y, platform_3_y, 50 * delta)

	if button_2.is_active():
		active_spikes_2.position.y = move_toward(active_spikes_2.position.y, -48, 50 * delta)
	else:
		active_spikes_2.position.y = move_toward(active_spikes_2.position.y, spikes_2_y, 50 * delta)

	if button_3.is_active():
		active_spikes_1.position.y = move_toward(active_spikes_1.position.y, -176, 50 * delta)
	else:
		active_spikes_1.position.y = move_toward(active_spikes_1.position.y, spikes_1_y, 50 * delta)

	if button_4.is_active():
		platform_4.position.y = move_toward(platform_4.position.y, -16, 50 * delta)
	else:
		platform_4.position.y = move_toward(platform_4.position.y, platform_4_y, 50 * delta)

	if cup.level_finished:
		var score = 1
		if ice_cube.collected:
			score += 1
		if syrup.collected:
			score += 1
		lvl_comp.score = score

		active_pos = Vector2(0, 0)
