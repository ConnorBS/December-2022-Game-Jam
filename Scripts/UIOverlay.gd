extends CanvasLayer

var score_value = 0


func add_score(value):
	score_value += value
	$HBoxContainer/ScorePoint.text = score_to_string(score_value)


func score_to_string(score):
	var string = str(score)
	while string.length() < 6:
		string = "0"+string
	return string
