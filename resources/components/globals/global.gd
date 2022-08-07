extends Node

var max_coins: int = 0
var coins_collected: int = 0
var timer: String = '00:00:000'
var current_lvl_name: String = ""

var current_save: SaveGame

var overview_map_data: Dictionary = {}

func get_time_format(time: float) -> String:
	var milliseconds = fmod(time, 1) * 1000
	var seconds = fmod(time, 60)
	var minutes = fmod(time, 3600) / 60
	var str_elapsed = "%02d : %02d : %03d" % [minutes, seconds,milliseconds ]
	return str_elapsed
