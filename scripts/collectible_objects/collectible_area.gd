extends Area2D


@export var type : Enums.collectables
@export var inventory_item_type : InventoryItem


@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var parent : Node2D = get_parent()


func _on_body_entered(body):
	match type:
		Enums.collectables.KEY:
			PlayerData.add_key()
			parent.queue_free()
		_:
			if body.player_inventory.add_item(inventory_item_type):
				parent.queue_free()
