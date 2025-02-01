extends Node2D

enum Variants {NORMAL, ALT, HEAVY}
@export var ButtonVariant = Variants.NORMAL

var bubbles: Dictionary = {}
var blocks: Dictionary = {}

@onready var top_sprites: Node2D = $Area2D/Sprites
@onready var top: Sprite2D = $Area2D/Sprites/Top
@onready var top_alt: Sprite2D = $Area2D/Sprites/TopAlt
@onready var top_heavy: Sprite2D = $Area2D/Sprites/TopHeavy

@onready var bottom_sprites: Node2D = $StaticBody2D/Sprites
@onready var bottom: Sprite2D = $StaticBody2D/Sprites/Bottom
@onready var bottom_alt: Sprite2D = $StaticBody2D/Sprites/BottomAlt
@onready var bottom_heavy: Sprite2D = $StaticBody2D/Sprites/BottomHeavy

@onready var button_hardener: CollisionPolygon2D = $ButtonHardener/CollisionPolygon2D

var top_pos: Vector2
var bot_pos: Vector2


func is_active() -> bool:
	if ButtonVariant == Variants.HEAVY:
		return bubbles.has("Bubble_3") or len(blocks) > 0
	else:
		return len(bubbles) > 0 or len(blocks) > 0


func _ready() -> void:
	button_hardener.set_deferred("disabled", true)

	top_pos = top_sprites.position
	bot_pos = Vector2(top_pos.x, top_pos.y + 4)


func _process(_delta: float) -> void:
	match ButtonVariant:
		Variants.NORMAL:
			top.show()
			bottom.show()
			top_alt.hide()
			bottom_alt.hide()
			top_heavy.hide()
			bottom_heavy.hide()
		Variants.ALT:
			top.hide()
			bottom.hide()
			top_alt.show()
			bottom_alt.show()
			top_heavy.hide()
			bottom_heavy.hide()
		Variants.HEAVY:
			top.hide()
			bottom.hide()
			top_alt.hide()
			bottom_alt.hide()
			top_heavy.show()
			bottom_heavy.show()

	if ButtonVariant == Variants.HEAVY:
		if bubbles.has("Bubble_3") or len(blocks) > 0:
			top_sprites.position = bot_pos
			button_hardener.set_deferred("disabled", true)
		else:
			top_sprites.position = top_pos
			button_hardener.set_deferred("disabled", false)
	elif len(bubbles) > 0 or len(blocks) > 0:
		top_sprites.position = bot_pos
	else:
		top_sprites.position = top_pos


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		bubbles[body.name] = null
	elif body is RigidBody2D:
		blocks[body.name] = null


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		bubbles.erase(body.name)
	elif body is RigidBody2D:
		blocks.erase(body.name)
