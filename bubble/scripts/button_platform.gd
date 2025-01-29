extends Node2D

enum Variants {NORMAL, ALT, HEAVY}
@export var ButtonVariant = Variants.NORMAL

var bubbles: Dictionary
var blocks: Dictionary

var top_sprites: Node2D
var top: Sprite2D
var top_alt: Sprite2D
var top_heavy: Sprite2D

var bottom_sprites: Node2D
var bottom: Sprite2D
var bottom_alt: Sprite2D
var bottom_heavy: Sprite2D

var button_hardener: CollisionPolygon2D

var top_pos: Vector2
var bot_pos: Vector2


func is_active() -> bool:
	if ButtonVariant == Variants.HEAVY:
		return bubbles.has("Bubble_3")
	else:
		return len(bubbles) > 0 or len(blocks) > 0


func _ready() -> void:
	bubbles = {}
	blocks = {}

	top_sprites = $Area2D/Sprites
	top = $Area2D/Sprites/Top
	top_alt = $Area2D/Sprites/TopAlt
	top_heavy = $Area2D/Sprites/TopHeavy

	bottom_sprites = $StaticBody2D/Sprites
	bottom = $StaticBody2D/Sprites/Bottom
	bottom_alt = $StaticBody2D/Sprites/BottomAlt
	bottom_heavy = $StaticBody2D/Sprites/BottomHeavy

	button_hardener = $ButtonHardener/CollisionPolygon2D

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
