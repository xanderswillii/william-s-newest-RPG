extends Area2D


var opened = false

func _ready():
	$anim.play("Closed")
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "player" and player_data.has_key and !opened:
		opened = true
		player_data.has_key = false
		player_data.life = 4
		$anim.play("Open")
