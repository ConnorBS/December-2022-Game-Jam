extends Node

var player_score:int =0
var player_highscore :int =0

func new_score (new_score_value):
	player_score = new_score_value
	if player_highscore < new_score_value:
		player_highscore= new_score_value
	
