extends KinematicBody2D

signal ballOut(side)
var  speed=500
var velocity = Vector2.ZERO

var player
var computer

func _ready():
	randomize() 
	position = Vector2(get_viewport().get_size().x/2, get_viewport().get_size().y/2)
	player=get_parent().find_node("player")
	computer=get_parent().find_node("computer")

func _physics_process(delta):

	if position.x < computer.get("left_limit"): 
		_stop("computer")
		return
	if position.x > get_viewport().get_size().x-player.get("right_limit"):
		_stop("player")
		return

# replaced by collide node  	
#	if position.y > get_viewport().get_size().y-$Ball.texture.get_height() or position.y < $Ball.texture.get_height() :
#		velocity.y *=-1

	var collision = move_and_collide(velocity*delta)
	if collision : 
		velocity = velocity.bounce(collision.get_normal())
		if collision.collider.name=="player" or collision.collider.name=="computer":
			$collisionSound.play()
	
func _stop(exit_side):
	position = Vector2(get_viewport().get_size().x/2, get_viewport().get_size().y/2)
	velocity=Vector2(0, 0)
	emit_signal("ballOut", exit_side)
	
	
func _restart(side2serve): 
	# losing player gets to serve the ball
	var choices=[-PI/4, -PI/6, PI/4, PI/6]
	var ang = choices[randi() % choices.size() -1]
	if side2serve=="player":
		ang= ang+PI
	velocity=Vector2(speed, 0).rotated(ang)

