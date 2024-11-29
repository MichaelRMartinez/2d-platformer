extends CharacterBody2D

const SPEED = 350.0
const JUMP_VELOCITY = -800.0
var jump_count = 0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func jump():
	velocity.y = JUMP_VELOCITY
	
func jump_side(x):
	velocity.y = JUMP_VELOCITY/2
	velocity.x = x

func _physics_process(delta: float) -> void:	
	# Add the gravity
	if is_on_floor():
		jump_count = 0
		
		if (velocity.x > 1 || velocity.x < -1):
			animated_sprite_2d.play("running")
		else:
			animated_sprite_2d.play("default")
	
	else:
		velocity += get_gravity() * delta
		if (jump_count == 2):
			animated_sprite_2d.animation = "double_jumping"
		else:
			animated_sprite_2d.play("jumping")

	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_count < 2:
		velocity.y = JUMP_VELOCITY
		jump_count += 1

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
		animated_sprite_2d.flip_h = true
	if Input.is_action_pressed("right"):
		animated_sprite_2d.flip_h = false
