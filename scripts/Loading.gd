extends Node2D

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var hint_label: Label = $HintLabel
@onready var horse: Sprite2D = $horse


func _ready():
	ResourceLoader.load_threaded_request(Global.scene_to_load)

func _process(delta: float) -> void:
	horse.rotate(1 * delta)
	var progress = []
	ResourceLoader.load_threaded_get_status(Global.scene_to_load, progress)
	progress_bar.value = progress[0] * 100
	
	if progress[0] == 1:
		var packed_scene = ResourceLoader.load_threaded_get(Global.scene_to_load)
		get_tree().change_scene_to_packed(packed_scene)
