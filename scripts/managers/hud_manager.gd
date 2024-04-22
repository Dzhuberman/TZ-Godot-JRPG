extends Node2D


# Interaction section
@onready var interaction_hud : CanvasLayer = $InteractionHud
@onready var interaction_label : Label = $InteractionHud/Panel/Label
@onready var interaction_timer : Timer = $InteractionHud/InteractionTimer

# Main HUD section
@onready var hp_label : Label = $MainHud/PlayerHudPanel/HPLabel
@onready var keys_label : Label = $MainHud/PlayerHudPanel/KeysLabel

# Confirmation window
signal confirmed(is_confirmed : bool)
@onready var confirm_window : CanvasLayer = $ConfirmationWindow
@onready var confirm_label : Label = $ConfirmationWindow/ConfirmationPanel/ConfirmationLabel
@onready var confirm_panel : Panel = $ConfirmationWindow/ConfirmationPanel
@onready var confirm_alert : Panel = $ConfirmationWindow/ConfirmationAlert
@onready var confirmation_alert_label : Label = $ConfirmationWindow/ConfirmationAlert/ConfirmationAlertLabel
@onready var confirmation_timer : Timer = $ConfirmationWindow/ConfirmationTimer

# Inventory
@onready var inventory_node : Control = $PlayerInventory/Inventory

# Game over
@onready var game_over_window : CanvasLayer = $GameOverScreen


func _process(_delta):
	_update_main_hud()


func _update_main_hud():
	hp_label.text = str("HP: ", PlayerData.current_health_points, "/", PlayerData.max_health_points)
	keys_label.text = str("Keys: ", PlayerData.keys)


#=========================================
#==============INTERACTION================
#=========================================
func activate_interaction(text : String):
	if text:
		interaction_timer.start()
		interaction_hud.show()
		interaction_label.text = text


func _on_interaction_timer_timeout():
	interaction_hud.hide()
	interaction_label.text = ""
#=========================================
#==============INTERACTION================
#=========================================


#=========================================
#=============CONFIRMATION================
#=========================================
func open_confirm_window(text : String):
	confirm_label.text = text
	confirm_window.show()


func open_confirm_alert(text : String):
	confirmation_alert_label.text = text
	confirm_window.show()
	confirm_panel.hide()
	confirm_alert.show()
	
	confirmation_timer.start()


func _on_confirm_button_pressed():
	confirmed.emit(true)
	confirm_window.hide()


func _on_cancel_button_pressed():
	confirmed.emit(false)
	confirm_window.hide()


func _on_confirmation_timer_timeout():
	confirmation_timer.stop()
	confirm_panel.show()
	confirm_alert.hide()
	confirm_window.hide()
#=========================================
#=============CONFIRMATION================
#=========================================


#=========================================
#===============INVENTORY=================
#=========================================
func show_inventory(inventory : Inventory, do_open : bool):
	if do_open:
		inventory_node.init_inventory(inventory)
	else:
		inventory_node.close_inventory()
#=========================================
#===============INVENTORY=================
#=========================================


#=========================================
#===============GAME OVER=================
#=========================================
func show_game_over_screen(do_show : bool):
	if do_show:
		game_over_window.show()
	else:
		game_over_window.hide()
#=========================================
#===============GAME OVER=================
#=========================================
