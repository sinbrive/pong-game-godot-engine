extends Node2D

onready var current=OS.get_system_time_msecs();

var  wait_state = true
var game_over = false

var BALL = preload("../Scenes/ball.tscn")

const GAME_OVER_VALUE=3

func _ready():
	
	OS.set_window_title("PONG Game 2023")
	$ball.connect("ballOut", self, "_ball_out")	
	
	$display/gameOver.hide()
	$display/guide.text="space to continue"
	
func _physics_process(delta):
	
	if game_over: 
		if Input.is_action_pressed("relaunch"):
			wait_state=false
			game_over=false
			$display/gameOver.hide()
			$display/guide.text=" "
			_resetAll()
		else:return

	print(Global.scoreC, Global.scoreP)
	$display/score_player.text=str(Global.scoreP)
	$display/score_computer.text=str(Global.scoreC)
	
	if Global.scoreP >= GAME_OVER_VALUE or Global.scoreC >= GAME_OVER_VALUE:
		game_over = true
		$display/gameOver.show()
		$display/guide.text=" r to run again"
	
	if wait_state:
		if Input.is_action_pressed("restart_game"):
			$ball._restart(true)  # to do launch side
			wait_state=false
			$display/guide.text=" "
	else:
		var timeDict = OS.get_system_time_msecs()-current;
		$display/time.text = str(timeDict/1000)+str((timeDict%1000/100)%100)

func _ball_out(exit_side):
	wait_state = true
	if exit_side == "player":
		Global.scoreC += 1
	else:
		Global.scoreP += 1
	$display/guide.text="space to continue"

func _resetAll():
	Global.scoreP=0
	Global.scoreC=0
	$display/gameOver.hide()
	current=OS.get_system_time_msecs();
	$ball._restart(true)
