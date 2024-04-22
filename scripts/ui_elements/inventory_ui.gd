extends Control


@export var slot : PackedScene
@export var button : PackedScene


var selected_item : InventoryItem
var inventory_instance : Inventory


@onready var inventory_grid : Control = $InventoryBackground/ItemsPanel/GridContainer
@onready var inventory_item_name : Label = $InventoryBackground/DescriptionPanel/NameLabel
@onready var inventory_item_description : Label = $InventoryBackground/DescriptionPanel/DescriptionLabel
@onready var inventory_buttons : Control = $InventoryBackground/ButtonsPanel/GridContainer
@onready var inventory_pointer : Control = $InventoryBackground/ItemsPanel/Pointer


func init_inventory(inventory : Inventory):
	if inventory.contents.size() == 0: return
	
	inventory_instance = inventory
	_update_inventory()
	
	show()


func close_inventory():
	hide()


func _update_inventory():
	if not is_instance_valid(inventory_instance): return
	
	for child in inventory_grid.get_children():
		child.queue_free()
	
	for item in inventory_instance.contents:
		_add_item(item)
	
	_draw_slot_data(inventory_instance.contents[0])
	selected_item = inventory_instance.contents[0]
	_set_pointer(inventory_grid.get_child(0).global_position)


func _add_item(item : InventoryItem):
	var temp_slot : Panel = slot.instantiate()
	if item != null:
		temp_slot.get_node("Image").texture = item.icon
		temp_slot.item = item
	
	temp_slot.selected.connect(_on_selected)
	
	inventory_grid.add_child(temp_slot)


func _on_selected(sel_slot : Panel):
	_set_pointer(sel_slot.global_position)
	selected_item = _select(sel_slot)
	_draw_slot_data(selected_item)


func _select(sel_slot : Panel) -> InventoryItem:
	if is_instance_valid(sel_slot.item):
		return sel_slot.item
	else:
		return null


func _draw_slot_data(item : InventoryItem):
	_remove_buttons()
	if is_instance_valid(item):
		inventory_item_name.text = item.name
		inventory_item_description.text = item.description
		if inventory_instance is PlayerInventory:
			_add_button("Use", item.can_use, _use_item)
			_add_button("Drop", item.can_drop, _drop_item)
	else:
		inventory_item_name.text = "Empty"
		inventory_item_description.text = "Empty cell"


func _add_button(text : String, enabled : bool, function : Callable):
	var temp_button : Button = button.instantiate()
	temp_button.text = text
	temp_button.disabled = not enabled
	
	temp_button.pressed.connect(function)
	
	inventory_buttons.add_child(temp_button)


func _remove_buttons():
	for child in inventory_buttons.get_children():
		child.queue_free()


func _use_item():
	selected_item.effect.use()
	if not selected_item.multiple_uses:
		inventory_instance.remove_item(selected_item)
	
	_update_inventory()


func _drop_item():
	inventory_instance.remove_item(selected_item)
	
	_update_inventory()


func _set_pointer(pos : Vector2):
	inventory_pointer.global_position = pos
