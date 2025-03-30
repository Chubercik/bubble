extends AudioStreamPlayer

func _process(_delta: float) -> void:
	self.volume_linear = Globals.volume / 100
