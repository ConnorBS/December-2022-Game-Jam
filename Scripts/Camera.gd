extends Camera2D

func _process(_delta):
	
	if get_parent().global_position.y <300:
		print (get_parent().global_position.y)
		self.global_position.y += (get_parent().global_position.y - self.global_position.y)/2*_delta
#	self.global_position.y = 270
	elif self.global_position.y > 200:
		self.global_position.y = 270
#
#	print (get_parent().position.y, " , ",global_position.y)
#	if get_parent().position.y < 200:
#
#		global_position.y += get_parent().global_position.y*_delta
#
#
