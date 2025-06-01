extends CharacterBody2D

@export var SPEED = 100

@onready var sprite = $Sprite2D

var dir : float
var spawnPos : Vector2
var spawnRot : float
var zdex : int
var _scale : Vector2

func _ready() -> void:
	global_position = spawnPos
	global_rotation = spawnRot
	z_index = zdex
	global_scale = _scale
	
	if dir > 0:
		sprite.flip_h = false
	elif dir < 0:
		sprite.flip_h = true
	
func _physics_process(delta):
	velocity = Vector2(SPEED, 0).rotated(dir)
	move_and_slide()

func _on_life_timeout() -> void:
	queue_free()
