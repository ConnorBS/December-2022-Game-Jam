extends Node2D
onready var _houseTile_node = $Houses
onready var _player_node = $Player


onready var cell_size = _houseTile_node.cell_size

var nextTile = Vector2(13,7)
var oldTile = Vector2(-2,7)
onready var gridPos_x = round(_player_node.position.x / cell_size.x)
var groundMoving = true
func update_tile():
	var listOfArrays = _houseTile_node.get_used_cells()
	for cell in listOfArrays:
		if cell.x == oldTile.x:
			_houseTile_node.set_cellv(cell,-1)
	
	_houseTile_node.set_cellv (nextTile,0)
	nextTile += Vector2(1,0)
	oldTile +=Vector2(1,0)


func _process(_delta):
	if round(_player_node.position.x / cell_size.x) > gridPos_x:
		for i in range(round(_player_node.position.x / cell_size.x - gridPos_x)):
			update_tile()
		gridPos_x = round(_player_node.position.x / cell_size.x)
		print (gridPos_x)
	pass


