extends Area2D

var velocity = Vector2.RIGHT

func _physics_process(delta):
	position += velocity * delta

var bullet_instance = Bullet.instantiate()
get_parent().add_child(bullet_instance)

extends Sprite2D

signal shoot(bullet, direction, location)

var Bullet = preload("res://bullet.tscn")

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			shoot.emit(Bullet, rotation, position)

func _process(delta):
	look_at(get_global_mouse_position())

func _on_player_shoot(Bullet, direction, location):
	var spawned_bullet = Bullet.instantiate()
	add_child(spawned_bullet)
	spawned_bullet.rotation = direction
	spawned_bullet.position = location
	spawned_bullet.velocity = spawned_bullet.velocity.rotated(direction)
