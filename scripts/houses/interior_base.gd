extends Node2D


@onready var exit_area : Area2D = $ExitArea


func _on_exit_area_body_entered(body):
	if not body.is_in_group("player"): return
	
	PlayerData.change_player_pos(body.house.exit_point.global_position)
	SceneManager.call_deferred("load_scene", SceneManager.main_level_scene)
