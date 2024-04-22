extends BaseEffect
class_name HealthEffect


@export var change_hp_by : int
@export var change_max_hp_by : int


func use():
	PlayerData.change_max_health_points(change_max_hp_by)
	PlayerData.change_health_points(change_hp_by)
