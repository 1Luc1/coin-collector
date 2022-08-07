extends Node2D

var _save: SaveGame

func _ready():
	_save = Global.current_save
	
	for child in get_children():
		child.connect("path_selected", get_parent()._on_pad_path_selected)
		child.connect("activated", self._on_pad_activated)
		
func _on_pad_activated(data):
	if _save and _save.level_time.has(data.name):
		data["time"] = _save.level_time[data.name]
	get_tree().call_group("gui", "set_level_data", data)
