extends Node

@onready var fps_label: Label = $CanvasLayer/FPSLabel

var scene_to_load = "res://scenes/Race.tscn"
var loading_screen = preload("res://scenes/Loading.tscn")

var fullscreen = false

func _process(delta: float) -> void:
	fps_label.text = "FPS: %s" % Engine.get_frames_per_second()
	
	if Input.is_action_just_pressed("fullscreen"):
		if fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		fullscreen = !fullscreen
