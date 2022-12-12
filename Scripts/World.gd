extends Node2D
onready var _houseTile_node = $Houses


var nextTile = Vector2(13,7)
var oldTile = Vector2(-2,7)
var gridPos
var groundMoving = true


func update_tile ():
	var listOfArrays = _houseTile_node.get_used_cells()
	for cell in listOfArrays:
		print (cell)
		if cell.x == oldTile.x:
			_houseTile_node.set_cellv(cell,-1)
	
	_houseTile_node.set_cellv (nextTile,0)
	nextTile += Vector2(1,0)
	oldTile +=Vector2(1,0)





func _on_SpawnNextBlock_timeout():
	update_tile()
	pass # Replace with function body.
