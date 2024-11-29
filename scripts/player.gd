extends CharacterBody2D

const SPEED = 350.0
const JUMP_VELOCITY = -800.0

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D


func jump():
	velocity.y = JUMP_VELOCITY
	
func jump_side(x):
	velocity.y = JUMP_VELOCITY/2
	velocity.x = x

func _physics_process(delta: float) -> void:
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.play("running")
	else:
		sprite_2d.play("default")
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		sprite_2d.play("jumping")

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 30)

	move_and_slide()
	
	# update sprite to face left if character is moving left
	if Input.is_action_pressed("left"):
		sprite_2d.flip_h = true
	if Input.is_action_pressed("right"):
		sprite_2d.flip_h = false
