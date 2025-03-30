extends Control

@onready var volume_icon: CheckButton = $VolumeIcon
@onready var volume_progress_bar: TextureProgressBar = $VolumeProgressBar
@onready var h_slider: HSlider = $VolumeProgressBar/HSlider


func _ready() -> void:
	h_slider.value = Globals.volume


func _process(_delta: float) -> void:
	Globals.volume = h_slider.value
	volume_progress_bar.value = h_slider.value
	if Globals.volume > 85:
		volume_icon.icon = load("res://sprites/volume_bar/icon_max.png")
	elif Globals.volume > 35:
		volume_icon.icon = load("res://sprites/volume_bar/icon_half.png")
	elif Globals.volume > 0:
		volume_icon.icon = load("res://sprites/volume_bar/icon_low.png")
	else:
		volume_icon.icon = load("res://sprites/volume_bar/icon_off.png")


func _on_volume_icon_toggled(_toggled_on: bool) -> void:
		h_slider.value = 0.0
		Globals.volume = 0.0
