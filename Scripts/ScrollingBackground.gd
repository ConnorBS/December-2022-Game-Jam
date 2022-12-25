extends Sprite

onready var player_node = get_parent().get_node("Player")

export (float) var max_scroll = 1

var scroll_speed = 0.00
var timer
var update_scroll = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.x = player_node.global_position.x
#	if update_scroll:
#		if scroll_speed <  max_scroll* player_node.velocity.x / player_node.speed:
#			print ("Trigger")
#			timer = Timer.new()
#			add_child(timer)
#			timer.wait_time = 0.2
#			timer.connect("timeout",self,"_timer_ended")
#			timer.start()
#			update_scroll = false
#
#			print (max_scroll," * ", player_node.velocity.x, " / ", player_node.speed)
#			scroll_speed += 0.005
#
#			material.set_shader_param("speed_scale",stepify(scroll_speed,0.001))
#	elif scroll_speed >  max_scroll* player_node.velocity.x / player_node.speed:
#		scroll_speed = max_scroll* player_node.velocity.x / player_node.speed
#		material.set_shader_param("speed_scale",0.001)
#
#func _timer_ended():
#	update_scroll = true
#	timer.queue_free()
