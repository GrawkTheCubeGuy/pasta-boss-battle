extends Node
class_name SaveDataManager

signal save_data_finished_loading

@onready var save_file_path : String = "user://save.tres"
static var save_data : SaveData

func _ready() -> void:
	if not ResourceLoader.exists(save_file_path):
		save_data = SaveData.new()
		ResourceSaver.save(save_data, save_file_path)
	else:
		save_data = ResourceLoader.load(save_file_path)
	emit_signal("save_data_finished_loading")
	update_save_data()
	
func update_save_data() -> void:
	ResourceSaver.save(save_data, save_file_path)
	print("done! save data is now:
	pizzaman_inventory: ", save_data.pizzaman_inventory, "
	has_beat_ds_mode: ", save_data.has_beat_ds_mode, "
	endless_high_score: ", save_data.endless_high_score)
