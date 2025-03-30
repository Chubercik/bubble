extends Control

@onready var volume_bar: Control = $VolumeBar
@onready var levels: Control = $Levels
@onready var credits: Control = $Credits


func _ready() -> void:
	levels.hide()
	credits.hide()


func _on_play_button_pressed() -> void:
	levels.show()


func _on_credits_button_pressed() -> void:
	volume_bar.hide()
	credits.show()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
