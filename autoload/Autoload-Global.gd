extends Node

@onready var fps_label: Label = $CanvasLayer/FPSLabel

var scene_to_load = "res://scenes/Race.tscn"
var loading_screen = preload("res://scenes/Loading.tscn")

func _process(delta: float) -> void:
	fps_label.text = "FPS: %s" % Engine.get_frames_per_second()
