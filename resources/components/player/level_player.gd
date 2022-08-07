extends CharacterBody2D

# https://www.youtube.com/watch?v=Luf2Kr5s3BM

@export var move_speed: float = 300
@export var starting_direction: Vector2 = Vector2(0,-1.1)
@export var zoom: Vector2 = Vector2(0.5, 0.5)
@export var show_ui: bool = true

@onready var animation_tree:AnimationTree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var audio_collect: AudioStreamPlayer2D = $AudioCollectCoin

func _ready():
	update_animation_parameters(starting_direction)
	$Camera2D.zoom = zoom
	for child in $Camera2D.get_children():
		child.visible = show_ui


func _process(_delta):
	$Camera2D/Timer.text = Global.timer
	$Camera2D/Coins.text = "%d / %d" % [Global.coins_collected, Global.max_coins]


func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if input_direction.length() > 1.0:
		input_direction = input_direction.normalized()
	
	update_animation_parameters(input_direction)

	input_direction.limit_length(1)
	velocity = input_direction * move_speed
	
	move_and_slide()

	pick_new_state()


func update_animation_parameters(move_input: Vector2) -> void:
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)


func pick_new_state() -> void:
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")


func collect_coin() -> void:
	audio_collect.play()
