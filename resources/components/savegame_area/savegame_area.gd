extends Area2D

enum CAMERA_DIRECTIONS {TOP_LEFT, TOP_RIGHT}

@export var save_game_name: String
@export var camera_direction: CAMERA_DIRECTIONS = CAMERA_DIRECTIONS.TOP_LEFT

var _save: SaveGame
var in_zone: bool = false
var delete_mode: bool = false
var max_coin_count: int = 0

@onready var label_3d: Label3D = $SubViewport/Label3D
@onready var viewport: Viewport = $SubViewport.get_viewport()

func _ready():
	# TODO this seems to use the same texture for all instances
	$Sprite2D.texture = viewport.get_texture()
	
	# load save game
	load_savegame()
	
	# set camera postion
	var current_camera: Camera3D = get_node("SubViewport/" + CAMERA_DIRECTIONS.keys()[camera_direction])
	current_camera.current = true
	
	# load coin count
	max_coin_count = get_max_coins_count()

func _process(_delta):
	if Input.is_action_just_pressed("select") and in_zone and !delete_mode:
		Global.current_save = _save
		SceneTransition.change_scene("res://resources/scenes/overview_map/overview_map.tscn")
	if Input.is_action_just_pressed("delete") and in_zone:
		label_3d.text = "Delete Savegame?"
		delete_mode = true
	if Input.is_action_just_pressed("select") and in_zone and delete_mode:
		if _save.delete_savegame():
			label_3d.text = "Savegame deleted!"
			load_savegame()
		else:
			label_3d.text = "Deletion failed!"
		delete_mode = false


func _on_save_game_area_body_entered(body):
	if body.is_in_group("player"):
		in_zone = true
		set_label_3d(in_zone)


func _on_save_game_area_body_exited(body):
	if body.is_in_group("player"):
		in_zone = false
		delete_mode = false
		set_label_3d(in_zone)


func load_savegame() -> void:
	_save = null
	_save = SaveGame.get_savegame("user://" + save_game_name +".tres")


func set_label_3d(set_label) -> void:
	if set_label:
		var text = "New Game"
		if !_save.level_time.is_empty():
			text = str(_save.get_collected_coins()) + " / " + str(max_coin_count) + " Coins"
		label_3d.text = text
	else:
		label_3d.text = ""
		
func get_max_coins_count() -> int:
	var dir := DirAccess.open("res://resources/scenes/levels/")
	var max_coins := 0
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir() and ".tscn" in file_name:
				max_coins += get_coins_count_from_scene(file_name)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("An error occurred when trying to access the path.")
	return max_coins
	
func get_coins_count_from_scene(file_name) -> int:
	var packed_scene: PackedScene = load("res://resources/scenes/levels/" + file_name)
	var coin_count := -1
	for node_name in packed_scene._bundled["names"]:
		if "Coin" in node_name:
			coin_count += 1
	return coin_count

