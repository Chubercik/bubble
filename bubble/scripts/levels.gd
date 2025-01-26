extends Control


func _on_level_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_level_2_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")


func _on_level_3_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_3.tscn")


func _on_level_4_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_4.tscn")


func _on_level_5_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_5.tscn")


func _on_level_6_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_6.tscn")


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
