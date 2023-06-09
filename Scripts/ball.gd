extends KinematicBody2D

signal ballOut
var  speed=300
var velocity = Vector2.ZERO

var player
var computer

func _ready():
	position = Vector2(get_viewport().get_size().x/2, get_viewport().get_size().y/2)
	player=get_parent().find_node("player")
	computer=get_parent().find_node("computer")

func _physics_process(delta):

	if position.x < computer.get("left_limit"): 
		_stop(false)
	if position.x > get_viewport().get_size().x-player.get("right_limit"):
		_stop(true)
		
	if position.y > get_viewport().get_size().y-$Ball.texture.get_height() or position.y < $Ball.texture.get_height() :
		velocity.y *=-1
		
	var collision = move_and_collide(velocity*delta)
	if collision :
		velocity = velocity.bounce(collision.get_normal())
	
func _stop(player_side):
	position = Vector2(get_viewport().get_size().x/2, get_viewport().get_size().y/2)
	velocity=Vector2(0, 0)
	if player_side: emit_signal("ballOut", "player")
	else: emit_signal("ballOut", "computer")
	
func _restart(side): 
	randomize() 
	var diff=rand_range(0.0,0.5)
	if side: velocity=Vector2(speed, 0).rotated(diff)
	else: velocity=Vector2(speed, 0).rotated(diff)

