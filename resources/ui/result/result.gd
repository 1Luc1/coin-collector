extends Control

func _ready():
	$time.text = Global.timer
	$goBackButton.connect("pressed", self._go_back_button_pressed)
	$goBackButton.grab_focus()

func _go_back_button_pressed():
	SceneTransition.change_scene("res://resources/scenes/overview_map/overview_map.tscn")
