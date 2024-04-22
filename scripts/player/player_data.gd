extends Node


var max_health_points : int = 10
var current_health_points : int = max_health_points
var keys : int = 0


@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")


func add_key():
	keys += 1


func delete_key():
	keys -= 1


func change_player_pos(pos : Vector2):
	player.global_position = pos


func clear_player_data():
	change_player_pos(Vector2.ZERO)
	max_health_points = 10
	current_health_points = max_health_points
	keys = 0


func change_health_points(delta : int):
	var new_hp : int = current_health_points + delta
	current_health_points = new_hp
	
	if new_hp <= 0:
		current_health_points = 0
	
	if new_hp >= max_health_points:
		current_health_points = max_health_points


func change_max_health_points(delta : int):
	if max_health_points + delta <= 0:
		max_health_points = 0
		current_health_points = max_health_points
	
	if current_health_points > max_health_points:
		current_health_points = max_health_points
	
	max_health_points += delta
