extends Camera2D

var velocity = Vector2(.1,0)
export (int) var speed = 20

func _process(delta):
	self.position.x = self.position.x + velocity.x


