extends Node2D
class_name Inventory


@export_range(0, 56) var inventory_size : int
@export var contents : Array[InventoryItem]


func init_inventory():
	contents.resize(inventory_size)


func add_item(item : InventoryItem) -> bool:
	if _check_inventory_full():
		return false
	else:
		contents[contents.find(null)] = item
		return true


# Removing element and adding new null element at the end to sort the array
func remove_item(item : InventoryItem):
	var i : int = contents.find(item)
	contents.remove_at(i)
	contents.push_back(null)


func remove_all_items():
	for i in contents:
		i = null


func _check_inventory_full():
	for i in contents:
		if i == null:
			return false
	
	return true
