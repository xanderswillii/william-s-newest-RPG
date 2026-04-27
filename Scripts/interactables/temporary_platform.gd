extends StaticBody2D

var triggered = false
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player" and !triggered:
		triggered = true
		await get_tree().create_timer(0.0).timeout
		$anim.play("Vanish")
		await $anim.animation_finished
		queue_free()
