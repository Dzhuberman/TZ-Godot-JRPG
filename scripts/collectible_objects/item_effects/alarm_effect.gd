extends BaseEffect
class_name AlarmEffect


func use():
	SceneManager.lock_all_doors(true)
