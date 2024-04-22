extends StaticBody2D
class_name HouseBase


# House Data
@export var is_locked : bool = true
@export var interior_scene : PackedScene
@export var exit_point : Node2D
# Sprites
@export var closed_house : Texture2D
@export var opened_house : Texture2D


@onready var house_sprite : Sprite2D = $Sprite2D
@onready var entrance_area : Area2D = $EntranceArea


func _ready():
	update_house_state()
	
	if not is_instance_valid(interior_scene):
		is_locked = true
		entrance_area.queue_free()


func _on_entrance_area_body_entered(body):
	if not body.is_in_group("player"): return
	body.house = self
	
	if is_locked:
		if PlayerData.keys > 0:
			HudManager.confirmed.connect(_on_confirmed)
			HudManager.open_confirm_window("Do you wish to spend 1 key to open this door?")
		else:
			HudManager.open_confirm_alert("Insufficient keys")
		return
	
	PlayerData.change_player_pos(Vector2.ZERO)
	SceneManager.call_deferred("load_scene", interior_scene)


func _on_confirmed(is_confirmed : bool):
	if is_confirmed:
		PlayerData.delete_key()
		is_locked = false
	
	HudManager.confirmed.disconnect(_on_confirmed)
	update_house_state()


func update_house_state():
	if is_locked:
		house_sprite.texture = closed_house
	else:
		house_sprite.texture = opened_house
