extends Control

@onready var _anim_player: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	_anim_player.play("appear")
	$Menu/Margin/Buttons/PlayButton.grab_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	for button in $Menu/Margin/Buttons.get_children():
		button.connect("focus_entered", self._on_button_focus_entered)


func _on_play_button_pressed():
	SceneTransition.change_scene("res://resources/scenes/savegame_select.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_credits_button_pressed():
	SceneTransition.change_scene("res://resources/ui/credits/credits.tscn")


func _on_button_focus_entered():
	audio.play()
