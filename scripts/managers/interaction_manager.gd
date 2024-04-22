extends Node2D


var target_interactable : Node2D


@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")


func _process(_delta):
	_interact_input()
	_show_hide_interaction()

func _interact_input():
	if not player.can_interact: return
	
	if Input.is_action_just_pressed("interaction"):
		target_interactable.interact()


func _show_hide_interaction():
	if player.can_interact:
		if is_instance_valid(target_interactable):
			target_interactable.show_interaction()
	else:
		if is_instance_valid(target_interactable):
			target_interactable.hide_interaction()
