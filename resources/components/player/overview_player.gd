extends CharacterBody2D

@onready var anim_player: AnimationPlayer = $AnimatedSprite2D/AnimationPlayer

func _ready():
	idle()


func move(direction) -> void:
	var anim_name: String = "walk_" + direction
	if anim_player.has_animation(anim_name):
		anim_player.play(anim_name)


func idle() -> void:
	anim_player.play("idle")


func rotate_player() -> void:
	anim_player.play("rotate")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "rotate":
		get_tree().call_group("pad", "load_level")
