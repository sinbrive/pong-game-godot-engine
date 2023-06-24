extends KinematicBody2D

onready var ball = get_parent().find_node("ball", false, true)
onready var left_limit = 50+$Computer.texture.get_width()

const SPEED=300

func _ready():
	position.x = 50
	
func _physics_process(delta):
	
	var velocity = Vector2.ZERO
	
	velocity.y = _getDirection()*SPEED
	
	move_and_slide(velocity)
	
func _getDirection():
	if abs(ball.position.y-position.y) > 25:
		if ball.position.y> position.y: return 1
		else: return -1
	else: return 0
	
