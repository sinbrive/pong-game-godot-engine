extends KinematicBody2D

onready var ball = get_parent().find_node("ball", false, true)
onready var left_limit = 50+$Computer.texture.get_width()

const SPEED=200

func _ready():
	position.x = 50
	
func _physics_process(delta):
	
#	var collision = move_and_collide(Vector2())
#	if not collision: move_and_slide(Vector2(0,_getDirection()) * SPEED*delta)
	move_and_collide(Vector2(0,_getDirection()) * SPEED*delta)
	
func _getDirection():
	if abs(ball.position.y-position.y) > 20:
		if ball.position.y> position.y: return 1
		else: return -1
	return 0
	
