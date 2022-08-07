extends CanvasLayer

func change_scene(target: String) -> void:
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene(target)
	$AnimationPlayer.play_backwards("dissolve")

func change_scene_to(packed_scene: Resource, scene_name: String) -> void:
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	$Label.text = scene_name
	$AnimationPlayer.play("show_label")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to(packed_scene)
	$Label.text = ""
	$AnimationPlayer.play_backwards("dissolve")
