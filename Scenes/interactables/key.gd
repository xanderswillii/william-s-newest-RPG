extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player_data.has_key = true
		$anim.play("Collected")
		await $anim.animation_finished
		queue_free()
