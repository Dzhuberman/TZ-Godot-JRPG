extends Node2D


signal interacted()


@export var interaction_image : Texture2D
@export var interaction_hud_text : String = "Interacted"


@onready var interaction_icon : TextureRect = $InteractionIcon


func show_interaction():
	interaction_icon.show()
	interaction_icon.texture = interaction_image


func hide_interaction():
	interaction_icon.hide()
	interaction_icon.texture = null


func interact():
	HudManager.activate_interaction(interaction_hud_text)
	interacted.emit()
