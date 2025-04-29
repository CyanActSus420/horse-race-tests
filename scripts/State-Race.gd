extends Node2D

@onready var hud: CanvasLayer = $HUD

@onready var time_scale_slider: HSlider = $HUD/TimeScale
@onready var time_scale_label: Label = $HUD/TimeScale/Label

@onready var time_label: Label = $Time/TimeLabel

# the countdown timer
@onready var timer: Timer = $Timer

# i know, i know its a shitty ass fix
var nanoseconds:int = 0
var tensofseconds:int = 0
var seconds:int = 0
var minutes:int = 0

func _ready():
	if Global.map_scene == null:
		push_error("map didnt load properly")
		return
	
	var map = Global.map_scene.instantiate()
	add_child(map)
	
	timer.start()

func _process(delta: float) -> void:
	time_scale_label.text = "TimeScale: x%s" % Engine.time_scale
	Engine.time_scale = time_scale_slider.value
	
	if Input.is_action_just_pressed("hidehud"):
		hud.visible = !hud.visible
	
	time_label.text = "%s:%s%s:%s" % [minutes, tensofseconds, seconds, nanoseconds]

func _on_timer_timeout() -> void:
	GameHandler.game_started.emit()
	$NanosecondTimer.start()

func _on_nanosecond_timer_timeout() -> void:
	nanoseconds += 1
	if nanoseconds == 10:
		nanoseconds = 0
		seconds += 1
		
	if seconds == 10:
		seconds = 0
		tensofseconds += 1
		
	if tensofseconds == 6:
		tensofseconds = 0
		minutes += 1
