extends Area2D

func _on_coin_body_entered(body):
	if body.is_in_group("player"):
		body.collect_coin()
		Global.coins_collected += 1
		queue_free()
