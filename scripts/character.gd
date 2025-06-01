extends CharacterBody2D


const SPEED = 75.0
const JUMP_VELOCITY = -200.0

@onready var main = get_tree().get_root().get_node("Game")
@onready var projectile = load("res://scenes/projectile.tscn")
@onready var animated_sprite = $AnimatedSprite2D

var shooting: bool

func _ready() -> void:
	shooting = false

func shoot():
	var direction = -1.0 if animated_sprite.flip_h else 1.0
	
	var instance = projectile.instantiate()
	instance.dir = direction
	instance.spawnPos = Vector2(direction * global_position.x + 7, global_position.y - 30)
	instance.spawnRot = rotation
	instance.zdex = z_index - 1
	instance._scale = Vector2(0.25,0.25)
	main.add_child.call_deferred(instance)

func _physics_process(delta: float) -> void:	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if shooting == true:
		animated_sprite.play("gun")
	elif direction > 0:
		animated_sprite.play("walking")
		animated_sprite.flip_h = false
		velocity.x = direction * SPEED
	elif direction < 0:
		animated_sprite.play("walking")
		animated_sprite.flip_h = true
		velocity.x = direction * SPEED
	else:
		animated_sprite.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		shooting = true
		#if get_rect().has_point(to_local(event.position)):
		#print('You clicked on Sprite')
		#animated_sprite.play("backpack")
	#elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)

	# Print the size of the viewport.
	#print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)



func _on_animated_sprite_animation_finished() -> void:
	shoot()
	shooting = false
