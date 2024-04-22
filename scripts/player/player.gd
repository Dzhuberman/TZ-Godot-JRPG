extends CharacterBody2D


@export var speed : float = 200.0


var can_interact : bool = false
var can_move : bool = true
var is_inventory_opened : bool = false


var house : StaticBody2D = null


@onready var look_direction : Node2D = $LookDirection
@onready var sprite : Sprite2D = $Sprite2D
@onready var direction_ray : RayCast2D = $LookDirection/RayCast2D
@onready var player_inventory : Inventory = $PlayerInventory


func _physics_process(delta):
	_move(delta)
	_open_inventory()
	
	# Checking if ray hits an interactable object
	can_interact = false
	if direction_ray.is_colliding():
		var interactable_area : Node2D = direction_ray.get_collider().get_node_or_null("InteractableArea")
		if interactable_area != null:
			InteractionManager.target_interactable = interactable_area
			can_interact = true
	
	move_and_slide()


# 4-directional move function
func _move(delta):
	if not can_move: return
	
	if Input.is_action_pressed("left"):
		position.x -= speed * delta
		look_direction.rotation = deg_to_rad(180)
		sprite.flip_h = true
		sprite.set_frame(6)
	elif Input.is_action_pressed("right"):
		position.x += speed * delta
		look_direction.rotation = deg_to_rad(0)
		sprite.flip_h = false
		sprite.set_frame(6)
	elif Input.is_action_pressed("up"):
		position.y -= speed * delta
		look_direction.rotation = deg_to_rad(270)
		sprite.set_frame(12)
	elif Input.is_action_pressed("down"):
		position.y += speed * delta
		look_direction.rotation = deg_to_rad(90)
		sprite.set_frame(0)


func _open_inventory():
	if Input.is_action_just_pressed("open_inventory"):
		if is_inventory_opened:
			is_inventory_opened = false
			can_move = true
			HudManager.show_inventory(player_inventory, false)
		else:
			is_inventory_opened = true
			can_move = false
			HudManager.show_inventory(player_inventory, true)
