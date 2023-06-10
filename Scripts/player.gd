extends KinematicBody2D

const SPEED=350

onready var right_limit = 50+$Player.texture.get_width()

func _ready():
	position.x = get_viewport().get_size().x-right_limit  
	position.y = get_viewport().get_size().y/2 

func _physics_process(delta):
	var velocity = Vector2.ZERO
	
	if (Input.is_action_pressed("move_up")):
		velocity.y -= SPEED
	if (Input.is_action_pressed("move_down")):
		velocity.y += SPEED

	move_and_slide(velocity)
#
#
