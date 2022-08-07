extends Control

func reset_level_data():
	$coin_label.text = ""
	$timer_label.text = ""
	$coin_icon.visible = false
	$timer_icon.visible = false

func set_level_data(data: Dictionary):
	$coin_label.text = data.coins
	$timer_label.text = Global.get_time_format(data.time) if data.has("time") else "-"
	$coin_icon.visible = true
	$timer_icon.visible = true
