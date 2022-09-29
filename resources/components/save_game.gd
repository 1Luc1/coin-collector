class_name SaveGame
extends Resource

@export var version := 1
@export var level_time: Dictionary = {}

var save_game_path: String

func set_save_game_path(path):
	save_game_path = path


func write_savegame() -> void:
	ResourceSaver.save(self, save_game_path)


func get_collected_coins() -> int:
	var coins: int = 0
	# get coin count from level name
	for level_time_index in level_time:
		coins += level_time_index.right(1).to_int()
	return coins


func delete_savegame() -> bool:
	var success: bool = false
	if save_exists(save_game_path):
		var dir = DirAccess.open("user://")
		success = dir.remove(save_game_path) == OK
	return success


static func get_savegame(path) -> SaveGame:
	var _save : SaveGame
	if SaveGame.save_exists(path):
		_save = SaveGame.load_savegame(path) as SaveGame
	else:
		_save = SaveGame.new()
	_save.set_save_game_path(path)
	return _save


static func save_exists(path) -> bool:
	return ResourceLoader.exists(path)


static func load_savegame(path) -> Resource:
	return ResourceLoader.load(path, "", true)
