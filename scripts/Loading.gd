extends Node2D

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var hint_label: Label = $HintLabel
@onready var horse: Sprite2D = $horse

var loading_texts = [
	"haha made you look",
	"who up racing their horse rn",
	"this is a hint",
	"check steam",
	"don't forget to like and subscribe!",
	"horses neigh",
	"no horses were hurt during this race",
	"place your bets while you're waiting",
	"horsey horsing horse",
	"hold shift to sprint",
	"did you know the horses have names? me neither",
	"you're reading this because it's loading"
]


func _ready():
	hint_label.text = loading_texts[randi_range(0, loading_texts.size() - 1)]
	ResourceLoader.load_threaded_request(Global.scene_to_load)

func _process(delta: float) -> void:
	horse.rotate(1 * delta)
	var progress = []
	ResourceLoader.load_threaded_get_status(Global.scene_to_load, progress)
	progress_bar.value = progress[0] * 100
	
	if progress[0] == 1:
		var packed_scene = ResourceLoader.load_threaded_get(Global.scene_to_load)
		get_tree().change_scene_to_packed(packed_scene)
