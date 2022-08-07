extends Node2D

var time = 0

func _ready():
	Global.max_coins = $TileMap/Coins.get_child_count()


func _process(delta):
	time += delta

	Global.timer = Global.get_time_format(time)

	if Global.max_coins == Global.coins_collected:
		var new_time = time
		var _save = Global.current_save
		if _save.level_time.has(Global.current_lvl_name):
			var current_time = _save.level_time[Global.current_lvl_name]
			if current_time < time:
				new_time = current_time
		_save.level_time[Global.current_lvl_name] = new_time
		_save.write_savegame()
		
		Global.overview_map_data["level_name"] = Global.current_lvl_name
		Global.max_coins = 0
		Global.coins_collected = 0
		
		SceneTransition.change_scene("res://resources/ui/result/result.tscn")
