extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -250.0
const IDLE_TIMER = 2.0
const SCALE = Vector2(0.9375, 0.9375)
const PUSH_FORCE = 34.5

var audio: AudioStreamPlayer2D

var active = false
var inactive_for = 0.0
var just_landed = 0.0

var last_pos: Vector2


func _ready() -> void:
	scale = SCALE
	audio = $AudioStreamPlayer2D

	last_pos = Vector2(0.0, 0.0)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		inactive_for = 0.0
		if active:
			rotation_degrees = Input.get_axis("ui_left", "ui_right") * 45
		scale.y = move_toward(scale.y, 1.2 * SCALE.y, delta)
		$AnimatedSprite2D.play("default")
		just_landed = 1.0
	elif inactive_for <= IDLE_TIMER:
		if just_landed > 0.0:
			scale.y = move_toward(scale.y, SCALE.y, delta)
			$AnimatedSprite2D.play("jump")
			just_landed -= delta
			if rotation != 0:
				just_landed = 0.0
		else:
			scale.y = move_toward(scale.y, SCALE.y, delta)
			$AnimatedSprite2D.play("default")
	else:
		scale.y = move_toward(scale.y, SCALE.y, delta)
		$AnimatedSprite2D.play("idle")

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and active:
		velocity.y = JUMP_VELOCITY
		audio.play()
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

	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			# Push the block up if it doesn't move
			if c.get_position() == last_pos:
				c.get_collider().apply_central_impulse(Vector2(0, -1) * PUSH_FORCE)
			else:
				c.get_collider().apply_central_impulse(-c.get_normal() * PUSH_FORCE)
			last_pos = c.get_position()

	inactive_for += delta
