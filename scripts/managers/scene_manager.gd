extends Node2D


var scenes_dict : Dictionary = {}


var main_level_scene : PackedScene
var parent_node : Node2D


@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var main_parent : Node2D = get_tree().get_first_node_in_group("main_scene")


func _clear_level():
	for key in scenes_dict:
		scenes_dict[key].queue_free()
	
	scenes_dict.clear()


func init_scene_manager(scene : PackedScene, levels_node : Node2D):
	_clear_level()
	PlayerData.clear_player_data()
	
	parent_node = levels_node
	main_level_scene = scene
	_add_scene_to_dict(scene, scene.instantiate())
	load_scene(scene)


func load_scene(scene : PackedScene):
	player.reparent(main_parent)
	
	_remove_scene()
	
	if not scenes_dict.has(scene):
		_add_scene_to_dict(scene, scene.instantiate())
		#print("Scene Instantiated")
	else:
		parent_node.add_child(scenes_dict[scene])

	player.reparent(scenes_dict[scene])


func _remove_scene():
	for child in parent_node.get_children():
		parent_node.remove_child(child)


func _add_scene_to_dict(scene : PackedScene, scene_node : Node2D):
	scenes_dict[scene] = scene_node


func lock_all_doors(lock : bool):
	if not scenes_dict.has(main_level_scene): return
	
	for child in scenes_dict[main_level_scene].get_children():
		if child is HouseBase:
			child.is_locked = lock
			child.update_house_state()
