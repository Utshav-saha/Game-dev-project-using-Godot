extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@onready var idle_left: Sprite2D = $IdleLeft
@onready var animation_player: AnimationPlayer = $IdleLeft/AnimationPlayer


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, +1
	var direction := Input.get_axis("move_left", "move_right")
	
	#Flip the sprite
	if direction > 0:
		idle_left.flip_h = false
	
	elif direction < 0:
		idle_left.flip_h = true
	
	# Play Animations
	
	if is_on_floor():
		
		if direction == 0:
			animation_player.play("idle")
	
		else:
			animation_player.play("run")
			
	
	else:
		animation_player.play("jump")
	

	# Apply Movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
