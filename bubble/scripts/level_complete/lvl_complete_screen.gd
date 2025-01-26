extends Control

var panel: Panel
var level_complete: AnimatedSprite2D
var good: AnimatedSprite2D
var great: AnimatedSprite2D
var perfect: AnimatedSprite2D

var replay_button: Button
var next_button: Button
var close_button: Button

var score = 0
var curr_scene = 0


func _ready() -> void:
	panel = $Panel
	level_complete = $LvlComplete
	good = $LvlCompleteGood
	great = $LvlCompleteGreat
	perfect = $LvlCompletePerfect

	replay_button = $ReplayButton
	next_button = $NextButton
	close_button = $CloseButton

	panel.hide()
	level_complete.hide()
	good.hide()
	great.hide()
	perfect.hide()

	replay_button.hide()
	next_button.hide()
	close_button.hide()


var timer: float
var start_1: float
var start_2: float

var lvl_complete_shown = false
var eval_shown = false


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
				close_button.show()
	timer += delta


func _on_replay_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_%d.tscn" % curr_scene)


# TODO: Last level is an edge case
# Too bad!
func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_%d.tscn" % (curr_scene + 1))


func _on_close_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
