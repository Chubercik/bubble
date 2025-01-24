extends Control

var levels: Control

func _ready() -> void:
	levels = $Levels


func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		levels.hide()


func _on_play_button_pressed() -> void:
	levels.show()


func _on_credits_button_pressed() -> void:
	pass


func _on_quit_button_pressed() -> void:
	get_tree().quit()
