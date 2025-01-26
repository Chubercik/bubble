extends Control

var levels: Control
var credits: Control

func _ready() -> void:
	levels = $Levels
	credits = $Credits

	levels.hide()
	credits.hide()


func _on_play_button_pressed() -> void:
	levels.show()


func _on_credits_button_pressed() -> void:
	credits.show()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
