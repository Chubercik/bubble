extends Control

@onready var volume_bar: Control = $VolumeBar
@onready var levels: Control = $Levels
@onready var credits: Control = $Credits
@onready var quit_button: Button = $QuitButton

func _ready() -> void:
	levels.hide()
	credits.hide()
	if OS.has_feature("web"):
		quit_button.hide()


func _on_play_button_pressed() -> void:
	volume_bar.hide()
	levels.show()


func _on_credits_button_pressed() -> void:
	volume_bar.hide()
	credits.show()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
