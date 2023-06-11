extends Node2D

onready var current=OS.get_system_time_msecs();

enum  {IDLE=1, RUNNING, OVER}

var state = IDLE

var ball_out_event=false
var time_out_event=false

const GAME_OVER_VALUE=11

func _ready():
	
	OS.set_window_title("PONG Game 2023")
	$ball.connect("ballOut", self, "_ball_out")	
	
	$display/gameOver.hide()
	$display/guide.text=" "
	
	$TimerResume.set_one_shot (true)
	$TimerResume.start()
	
func _process(delta):
	
	$display/score_player.text=str(Global.scoreP)
	$display/score_computer.text=str(Global.scoreC)
	
	if state==IDLE:
		$display/timer_label.text=str(int($TimerResume.time_left))
		if time_out_event:
			time_out_event=false
			state=RUNNING
			$display/timer_label.text=" "
			$ball._restart(true)  # to do : manage which side to launch 
	
	elif state==RUNNING:
		display_time()
		if ball_out_event:
			$TimerResume.start()
			state=IDLE
			ball_out_event=false

		if Global.scoreP >= GAME_OVER_VALUE or Global.scoreC >= GAME_OVER_VALUE:
			state=OVER
			$TimerResume.stop()
			$display/gameOver.show()
			$display/guide.text=" R to run again"
		
	elif state==OVER:
		if Input.is_action_pressed("relaunch"):
			state=RUNNING
			_resetAll()
			
	else:return
	

func _ball_out(exit_side):
	ball_out_event=true
	if exit_side == "player":
		Global.scoreC += 1
	else:
		Global.scoreP += 1

func _resetAll():
	Global.scoreP=0
	Global.scoreC=0
	$display/gameOver.hide()
	$display/guide.text=" "
	current=OS.get_system_time_msecs();
	$ball._restart(true)

func _on_TimerResume_timeout():
	time_out_event=true

func display_time():
	var timeDict = OS.get_system_time_msecs()-current;
	$display/time.text = str(timeDict/1000)+str((timeDict%1000/100)%100)
