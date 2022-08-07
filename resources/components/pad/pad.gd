extends Area2D

signal path_selected(path, backward, direction)
signal activated(pad)

@export var input_mapping: Dictionary
@export var paths: Array[NodePath]
@export var backward: Array[bool]
@export var level: Resource
@export var level_name: String
@export var level_coins: String = "-"

var is_active: bool = false
# TODO how to use set_process() instead of bool var?

func _process(_delta):
	if is_active:
		for input in Const.INPUTS:
			if Input.is_action_just_pressed(Const.INPUTS[input]) and input_mapping.has(Const.INPUTS[input]):
				var index = input_mapping[Const.INPUTS[input]]
				emit_signal("path_selected", get_node(paths[index]), backward[index], Const.INPUTS[input])
				is_active = false
		if Input.is_action_just_pressed("select") and level != null:
			get_tree().call_group("player", "rotate_player")


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		is_active = true
		emit_signal("activated", {"name":level_name, "coins": level_coins})


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		is_active = false
		get_tree().call_group("gui", "reset_level_data")


func get_forward_path() -> Node:
	var path: Node = null
	for i in range(0, backward.size()):
		if !backward[i]:
			path = get_node(paths[i])
	return path


func load_level() -> void:
	if is_active:
		Global.current_lvl_name = level_name
		SceneTransition.change_scene_to(level, level_name)
