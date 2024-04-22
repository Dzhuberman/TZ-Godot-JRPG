extends Node2D


@export var levels : Array[PackedScene]


@onready var level_node : Node2D = $Level
@onready var timer : Timer = $Timer


func _ready():
	if levels.size() == 0: return
	
	SceneManager.init_scene_manager(levels[0], level_node)


func _process(_delta):
	_check_game_over()


func _check_game_over():
	if PlayerData.current_health_points <= 0:
		_game_over()


#This "game over" is just so we can test project
func _game_over():
	HudManager.show_game_over_screen(true)
	PlayerData.max_health_points = 10
	PlayerData.current_health_points = 10
	timer.start()


func _on_timer_timeout():
	HudManager.show_game_over_screen(false)
	timer.stop()
