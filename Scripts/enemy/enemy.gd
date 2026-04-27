extends CharacterBody2D

@export var speed = 80.0
@export var gravity = 10
var direction = 1
var can_flip = true
var already_hit = false
var life = 2

@onready var wall = $wall_ray

func _physics_process(delta):
	movement(delta)

func movement(delta):
	velocity.x = speed * direction
	
	if wall_collider() and can_flip:
		direction *= -1
		can_flip = false
		await get_tree().create_timer(0.5).timeout
		can_flip = true
	
	wall.scale.x = direction
	
	if direction > 0:
		$anim.play("walk")
	elif direction < 0:
		$anim.play("walk_left")
	
	gravity_force()
	move_and_slide()

func gravity_force():
	if !wall_collider():
		velocity.y += gravity
	else:
		velocity.y += 0.3

func take_damage():
	life -= 1
	if life <= 0:
		queue_free()
		
		
func wall_collider():
	return wall.is_colliding()


func _on_area_2d_body_entered(body):
	if body.name == "player":
		if !already_hit:
			already_hit = true
			player_data.life -= 1
			await get_tree().create_timer(1.0).timeout
			already_hit = false


func _on_hitbox_area_entered(area: Area2D):
	if area.name == "sword":
		life -= 1
		if life <= 0:
			queue_free() 
