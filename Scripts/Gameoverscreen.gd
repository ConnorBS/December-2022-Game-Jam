extends CanvasLayer

onready var score_value_node = $PanelContainer/MarginContainer/VBoxContainer/CenterContainer/VBoxContainer/HBoxContainer/NormalScore


func _ready():
	score_value_node.text = str(PlayerStats.player_score)

func _on_RESTART_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_QUIT_pressed() -> void:
	get_tree().quit()
