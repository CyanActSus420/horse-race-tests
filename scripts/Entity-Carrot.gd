extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Horse"):
		print("%s won the race" % body.Name)
		get_tree().change_scene_to_file("res://scenes/Loading.tscn")
