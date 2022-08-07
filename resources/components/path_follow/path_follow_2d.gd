extends PathFollow2D

var backward: bool = false
var _idle: bool = true
@onready var player: CharacterBody2D = $OverviewPlayer

func move(direction):
	_idle = false
	player.move(direction)
	
func idle():
	_idle = true
	player.idle()

func _process(delta):
	if !_idle:
		if backward:
			offset -= 250 * delta
			if unit_offset == 0:
				idle()
		else:
			offset += 250 * delta
			if unit_offset == 1:
				idle()

func _on_map_path_entered(moving_direction, direction):
	backward = moving_direction
	if backward:
		unit_offset = 1
	else:
		unit_offset = 0
	move(direction)
