extends Node2D

@onready var hud: CanvasLayer = $HUD

@onready var time_scale_slider: HSlider = $HUD/TimeScale
@onready var time_scale_label: Label = $HUD/TimeScale/Label

func _process(delta: float) -> void:
	time_scale_label.text = "TimeScale: x%s" % Engine.time_scale
	Engine.time_scale = time_scale_slider.value
	
	if Input.is_action_just_pressed("hidehud"):
		hud.visible = !hud.visible

func _on_timer_timeout() -> void:
	GameHandler.game_started.emit()
