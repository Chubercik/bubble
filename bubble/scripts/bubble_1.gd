extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const IDLE_TIMER = 2.0

var active = false
var inactive_for = 0.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		inactive_for = 0.0
		rotation = 0
		$AnimatedSprite2D.play("jump")
	elif inactive_for <= IDLE_TIMER:
		$AnimatedSprite2D.play("default")
	else:
		$AnimatedSprite2D.play("idle")

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and active:
		velocity.y = JUMP_VELOCITY
		inactive_for = 0.0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction and active:
		velocity.x = direction * SPEED
		rotation += direction / 5
		inactive_for = 0.0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	inactive_for += delta
