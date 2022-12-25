extends Node2D
onready var _houseTile_node = $Houses
onready var _player_node = $Player

var death_depth = 8

onready var cell_size = _houseTile_node.cell_size
enum TILESET{DEFAULT,HOUSE1,CHIMNEY1,HOUSE2}

var nextTile = Vector2(12,7)
var lastUpdateTile = Vector2(12,7)
var oldTile = Vector2(-9,7)

export (float) var chance_of_gap = 0.2
export (float) var chance_of_chimeny = .1
export (int) var count_gap_max = 2
export (int) var min_gap_of_chimneys = 7
export (int) var spawn_distance = 500

var current_gap_count = 0
var last_chimney_position_x= 0

onready var sky = preload("res://Scenes/Sky.tscn")
onready var mountains = preload("res://Scenes/Mountains.tscn")

#onready var previous_sky:Node
#onready var previous_mountains:Node
onready var current_sky:Node = $Sky
onready var current_mountains:Node = $Mountains

onready var ui_overlay_node = $UIOverlay

const platform_dict = {
	"house1":{
		"tileset":TILESET.HOUSE1,
		"next open slot": +4,
		"offset position": Vector2(0,-1)
		
	},
	"chimney1":{
		"tileset":TILESET.CHIMNEY1,
		"next open slot": +1,
		"offset position": Vector2(0,-2)
	},
	"house2":{
		"tileset":TILESET.HOUSE2,
		"next open slot": +6,
		"offset position": Vector2(0,-1)
		
	},
}
onready var gridPos_x = round(_player_node.position.x / cell_size.x)
var groundMoving = true

func _ready():
	randomize()
	set_starting_platform()


func clear_old_tiles():
	var listOfArrays = _houseTile_node.get_used_cells()
	for cell in listOfArrays:
		if cell.x == oldTile.x:
			_houseTile_node.set_cellv(cell,-1)
	
	oldTile +=Vector2(1,0)


func _process(_delta):
	if round(_player_node.position.x / cell_size.x) > gridPos_x:
		for i in range(round(_player_node.position.x / cell_size.x - gridPos_x)):
			clear_old_tiles()
			ui_overlay_node.add_score(1)
		gridPos_x = round(_player_node.position.x / cell_size.x)
		while (nextTile.x < spawn_distance+gridPos_x):
			nextTile.x += 1
			if nextTile.x >= lastUpdateTile.x:
				var random_chance_of_gap = randf()
				
				var gap_spawned = false
				if chance_of_gap >= random_chance_of_gap and current_gap_count <= chance_of_gap:
					current_gap_count += 1
					lastUpdateTile.x += 2
					gap_spawned = true
#					print ("Spawned gap: ", nextTile)
				
				if !gap_spawned:
					var random_chance_of_chimney = randf()
					if chance_of_chimeny >= random_chance_of_chimney and nextTile.x - last_chimney_position_x >= min_gap_of_chimneys:
						spawn_chimney(nextTile)
#						print ("Spawned Chimney: ",nextTile)
					
					current_gap_count = 0
					determine_house()
			
			
#			print ("Next Tile: ",nextTile)
#			print ("Last Updated tile: ", lastUpdateTile)

		
	if round(_player_node.position.y / cell_size.y) >= death_depth:
		get_tree().reload_current_scene()
	pass

func check_forParralax(node):
	node =$Sky
	
func determine_house():
	var house_int = round(rand_range(1,2))
#	print (house_int)
	var house_values = platform_dict["house"+str(house_int)]
	
	_houseTile_node.set_cellv (nextTile+house_values["offset position"],house_values["tileset"])
	lastUpdateTile.x += house_values["next open slot"]
#	print ("Spawned House: ", "house"+str(house_int), " ",nextTile)
	
func spawn_chimney(position_to_spawn):
	var chimney_int = round (rand_range(1,1))
	var chimney_values = platform_dict["chimney"+str(chimney_int)]
	
	_houseTile_node.set_cellv(position_to_spawn+chimney_values["offset position"], chimney_values["tileset"])
	last_chimney_position_x = position_to_spawn.x+chimney_values["offset position"].x

func set_starting_platform():
	_houseTile_node.set_cellv(Vector2(-1,6), TILESET.HOUSE1)
	_houseTile_node.set_cellv(Vector2(3,6), TILESET.HOUSE1)
	_houseTile_node.set_cellv(Vector2(7,6), TILESET.HOUSE2)


func _on_Area2D_area_exited(area):
#	print (area.get_parent().get_parent().name)
	if area.is_in_group("Sky") :#and area.get_parent().get_parent()==current_sky:
#		if previous_sky != null:
#			previous_sky.queue_free()
#		previous_sky = current_sky
		current_sky = sky.instance()
		current_sky.get_node("ParallaxLayer").global_position.x += $Player.global_position.x + 750
		add_child(current_sky)
		move_child(current_sky,0)
		
	elif area.is_in_group("Mountains"):#and area.get_parent().get_parent()==current_mountains:
#		print ("success")
#		if previous_mountains != null:
#			previous_mountains.queue_free()
#		previous_mountains =  current_mountains
		current_mountains = mountains.instance()
		current_mountains.get_node("ParallaxLayer").global_position.x += $Player.global_position.x + 750
		add_child(current_mountains)
		move_child(current_mountains,1)
		
	pass # Replace with function body.


func _on_Exit_area_exited(area):
	area.get_parent().get_parent().queue_free()
	pass # Replace with function body.
