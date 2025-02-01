extends Control

@onready var panel: Panel = $Panel
@onready var level_complete: AnimatedSprite2D = $LvlComplete
@onready var good: AnimatedSprite2D = $LvlCompleteGood
@onready var great: AnimatedSprite2D = $LvlCompleteGreat
@onready var perfect: AnimatedSprite2D = $LvlCompletePerfect

@onready var replay_button: Button = $ReplayButton
@onready var next_button: Button = $NextButton
@onready var close_button: Button = $CloseButton

var score: int = 0
var curr_scene: int = 0


func _ready() -> void:
	panel.hide()
	level_complete.hide()
	good.hide()
	great.hide()
	perfect.hide()

	replay_button.hide()
	next_button.hide()
	close_button.hide()


var timer: float = 0.0
var start_1: float = 0.0
var start_2: float = 0.0

var lvl_complete_shown: bool = false
var eval_shown: bool = false


func show_level_complete() -> void:
	if not lvl_complete_shown:
		level_complete.show()
		level_complete.play("default")
		start_1 = timer
		lvl_complete_shown = true


func show_good() -> void:
	if not eval_shown:
		good.show()
		good.play("default")
		start_2 = timer
		eval_shown = true


func show_great() -> void:
	if not eval_shown:
		great.show()
		great.play("default")
		start_2 = timer
		eval_shown = true


func show_perfect() -> void:
	if not eval_shown:
		perfect.show()
		perfect.play("default")
		start_2 = timer
		eval_shown = true


func _process(delta: float) -> void:
	if score > 0:
		panel.show()
		show_level_complete()
		close_button.show()
		if timer - start_1 > 2.0:
			if score == 1:
				show_good()
			elif score == 2:
				show_great()
			else:
				show_perfect()
			if timer - start_2 > 1.0:
				replay_button.show()
				next_button.show()
	timer += delta


func _on_replay_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_%d.tscn" % curr_scene)


# TODO: Last level will attempt
# switching to a non-existent
# scene.
#
# Too bad!
func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_%d.tscn" % (curr_scene + 1))


func _on_close_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
