extends Camera2D
func _process(_delta):
	if self.global_position.y > 270:
		self.global_position.y = 270
