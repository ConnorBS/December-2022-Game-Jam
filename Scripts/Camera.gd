extends Camera2D

func _process(_delta):
	
	if get_parent().global_position.y <300:
		print (get_parent().global_position.y)
		self.global_position.y += (get_parent().global_position.y - self.global_position.y)/2*_delta


	elif self.global_position.y > 200:
		self.global_position.y = 270
#
