extends Panel


signal selected


var item : InventoryItem
var mouse_over = false


func _input(event):
	if not event is InputEventMouseButton: return
	if event.is_pressed() and mouse_over == true:
		selected.emit(self)


func _on_mouse_entered():
	mouse_over = true


func _on_mouse_exited():
	mouse_over = false
