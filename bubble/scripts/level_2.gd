extends Node2D

@onready var bubble_1: CharacterBody2D = $Bubble_1
@onready var bubble_2: CharacterBody2D = $Bubble_2

@onready var camera: Camera2D = $Camera2D
@onready var cup: StaticBody2D = $Cup

@onready var ice_cube: Area2D = $IceCube
@onready var syrup: Area2D = $Syrup

@onready var spikes_1: TileMapLayer = $Level_2_tiled/Spikes_1
@onready var spikes_2: TileMapLayer = $Level_2_tiled/Spikes_2
var spikes_1_y: float
var spikes_2_y: float

@onready var button_1: Node2D = $Buttons/Button_1
@onready var button_2: Node2D = $Buttons/Button_2

@onready var platform: Node2D = $Platform
var platform_y: float

@onready var bubble_indicator: Sprite2D = $Level_2_tiled/BubbleIndicator

@onready var lvl_comp: Control = $LvlCompleteScreen


func _ready() -> void:
	spikes_1_y = spikes_1.position.y
	spikes_2_y = spikes_2.position.y

	platform_y = platform.position.y

	lvl_comp.curr_scene = 2

	bubble_1.active = true

	bubble_indicator.modulate = Color.html("#8350b0")


func _process(delta: float) -> void:
	# Quit level.
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

	# Restart level.
	if Input.is_key_pressed(KEY_R):
		get_tree().change_scene_to_file("res://scenes/level_2.tscn")

	# Switch between bubbles.
	if Input.is_key_pressed(KEY_1):
		bubble_1.active = true
		bubble_2.active = false
		bubble_indicator.modulate = Color.html("#8350b0")
	elif Input.is_key_pressed(KEY_2):
		bubble_1.active = false
		bubble_2.active = true
		bubble_indicator.modulate = Color.html("#00cdc3")

	var all_spikes = spikes_1.get_children() + spikes_2.get_children()
	for spike in all_spikes:
		if spike.dead:
			var tree = get_tree()  # This can be `null` for some reason
			if tree:  # Ensure it's not
				tree.change_scene_to_file("res://scenes/level_2.tscn")

	if button_1.is_active():
		spikes_1.position.y = move_toward(spikes_1.position.y, spikes_1_y + 32, 50 * delta)
		spikes_2.position.y = move_toward(spikes_2.position.y, spikes_2_y - 32, 50 * delta)
	else:
		spikes_1.position.y = move_toward(spikes_1.position.y, spikes_1_y, 50 * delta)
		spikes_2.position.y = move_toward(spikes_2.position.y, spikes_2_y, 50 * delta)

	if button_2.is_active():
		platform.position.y = move_toward(platform.position.y, 64, 50 * delta)
	else:
		platform.position.y = move_toward(platform.position.y, platform_y, 50 * delta)

	if cup.level_finished:
		var score = 1
		if ice_cube.collected:
			score += 1
		if syrup.collected:
			score += 1
		lvl_comp.score = score
