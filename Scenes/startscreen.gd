extends CanvasLayer




func _on_START_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_QUIT_pressed() -> void:
	get_tree().quit()
