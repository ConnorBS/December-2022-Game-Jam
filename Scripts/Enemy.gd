extends KinematicBody2D


export var speed = 150
export var motion = Vector2()
export var gravity = 20

var flipped = false
var animating = false
var direction = 1

func _physics_process(delta):
	if self.is_on_floor() and !animating:
		if $GroundCheck.is_colliding() == false or $WallCheck.is_colliding():
			flipped = !flipped
			tween()
	motion.y += gravity
	motion.x =+ speed * direction
	if is_on_wall():
		direction = direction * -1
	if flipped:
		motion.x = -motion.x
	motion = move_and_slide(motion,Vector2.UP)
	print(scale.x)
	if self.position.y > 500:
		self.queue_free()
	

func tween():
	$Tween.interpolate_property(self,"scale:x",scale.x,-scale.x,.2,Tween.TRANS_LINEAR)
	$Tween.start()
	
	animating = true
	



func _on_body_body_entered(body):
	if body.get_name() == "Player":
		get_tree().change_scene("res://Scenes/Gameoverscreen.tscn")


func _on_Tween_tween_all_completed():
	animating = false
	pass # Replace with function body.

#
#func _on_Tween_tween_step(object, key, elapsed, value):
#	print(object,",",key,",",elapsed,",",value)
#	pass # Replace with function body.
