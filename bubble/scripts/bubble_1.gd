extends CharacterBody2D


const SPEED: float = 150.0
const JUMP_VELOCITY: float = -250.0
const IDLE_TIMER: float = 2.0
const SCALE: Vector2 = Vector2(0.9375, 0.9375)

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

var active: bool = false
var inactive_for: float = 0.0
var just_landed: float = 0.0


func _ready() -> void:
	scale = SCALE


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		inactive_for = 0.0
		if active:
			sprite.rotation_degrees = Input.get_axis("ui_left", "ui_right") * 45
		sprite.scale.y = move_toward(sprite.scale.y, 1.2, delta)
		$AnimatedSprite2D.play("default")
		just_landed = 1.0
	elif inactive_for <= IDLE_TIMER:
		if just_landed > 0.0:
			sprite.scale.y = move_toward(sprite.scale.y, 1, delta)
			$AnimatedSprite2D.play("jump")
			just_landed -= delta
			if sprite.rotation != 0:
				just_landed = 0.0
		else:
			sprite.scale.y = move_toward(sprite.scale.y, 1, delta)
			$AnimatedSprite2D.play("default")
	else:
		sprite.scale.y = move_toward(sprite.scale.y, 1, delta)
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
		sprite.rotation += direction / 5
		inactive_for = 0.0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	inactive_for += delta
