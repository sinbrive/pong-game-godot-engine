extends KinematicBody2D

const SPEED=350

#onready var sprite = $Player
# or onready var sprite = self.find_node("Player")
#or @onready var sprite =self.get_node("Player/sprite")

onready var sprite = self.find_node("Player", true, false)
onready var ball = get_parent().find_node("ball", false, true)
onready var right_limit = 50+$Player.texture.get_width()

#preload("res://Assets/arts/Computer.png")
#usage : sprite.get_height()

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = get_viewport().get_size().x-67  # make 67 as result of calculation
	position.y = get_viewport().get_size().y/2 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var collision = move_and_collide(Vector2(0,0))
			
	if Input.is_action_pressed("move_up") and not collision:
		position.y -= SPEED*delta
	if Input.is_action_pressed("move_down"):
		position.y += SPEED*delta
		
	if position.y > get_viewport().get_size().y - sprite.texture.get_height():
		position.y = get_viewport().get_size().y - sprite.texture.get_height() 


