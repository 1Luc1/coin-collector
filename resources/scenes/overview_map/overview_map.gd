extends Node2D

signal path_entered(moving_direction)

var current_path_follow: PathFollow2D

func _ready():
	current_path_follow = $Paths/Path2D/PathFollow2D
	connect("path_entered", current_path_follow._on_map_path_entered)
	
	if Global.overview_map_data.has("level_name"):
		for pad in $Pads.get_children():
			if pad.level_name == Global.overview_map_data.level_name:
				var path = pad.get_forward_path()
				if path:
					move_path_follow_to_path(path)
					#draw_line_on_path(path)
				else:
					emit_signal("path_entered", Const.MOVING_DIRECTION.FORWARD, "right")
	else:
		emit_signal("path_entered", Const.MOVING_DIRECTION.FORWARD, "right")

func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		# TODO make actual ui to ask if exiting game
		Global.overview_map_data = {}
		Global.current_save = null
		SceneTransition.change_scene("res://main.tscn")

func _on_pad_path_selected(path, backward, direction):
	move_path_follow_to_path(path)
	emit_signal("path_entered", backward, direction)
	
func move_path_follow_to_path(path) -> void:
	var parent_path = current_path_follow.get_parent()
	parent_path.remove_child(current_path_follow)
	path.add_child(current_path_follow)
	
func draw_line_on_path(path) -> void:
	var l := Line2D.new()   
	l.default_color =  Color8(237, 140, 29)  
	l.width = 2 
	for point in path.curve.get_baked_points():  
		l.add_point(point + path.position)
	add_child(l)
