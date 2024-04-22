extends Resource
class_name InventoryItem

# Data
@export var icon : Texture
@export var name : String
@export var description : String
# Actions
@export var can_use : bool = false
@export var multiple_uses : bool = false
@export var can_drop : bool = false
# Effect
@export var effect : BaseEffect
