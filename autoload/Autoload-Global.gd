extends Node

@onready var fps_label: Label = $CanvasLayer/FPSLabel

func _process(delta: float) -> void:
	fps_label.text = "FPS: %s" % Engine.get_frames_per_second()
