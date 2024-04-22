extends StaticBody2D


@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var interactable_area : Node2D = $InteractableArea


func _on_interactable_area_interacted():
	_open()


func _open():
	anim_player.play("open")
	interactable_area.queue_free()
