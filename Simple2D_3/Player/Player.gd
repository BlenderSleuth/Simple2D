extends KinematicBody2D

class_name Player

var velocity = Vector2()

onready var sprite: AnimatedSprite = $AnimatedSprite
onready var jump_audio: AudioStreamPlayer = $AudioStreamPlayer
onready var land_audio: AudioStreamPlayer = $AudioStreamPlayer2

# tweakables
const WALK_SPEED = 50
const AIR_SPEED = 20
const GRAVITY = 1000
const JUMP_SPEED = 600

const WALK_DAMP = 0.85
const AIR_DAMP = 0.96

const MOVE_THRESHOLD = 50

var falling = false
var stopped = false
var walking_left = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_input():
	if Input.is_action_pressed('right'):
		if is_on_floor():
			velocity.x += WALK_SPEED
		else:
			velocity.x += AIR_SPEED
		walking_left = false
	if Input.is_action_pressed('left'):
		if is_on_floor():
			velocity.x += -WALK_SPEED
		else:
			velocity.x += -AIR_SPEED
		walking_left = true
	if Input.is_action_pressed('jump'):
		if is_on_floor():
			velocity.y -= JUMP_SPEED
			jump_audio.play()

func _physics_process(delta: float) -> void:
	get_input()

	if walking_left:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

	if abs(velocity.x) < MOVE_THRESHOLD:
		stopped = true
	else:
		stopped = false

	if falling:
		sprite.animation = "jump"
	else:
		if stopped:
			sprite.animation = "stand"
		else:
			sprite.animation = "walk"

	velocity.y += GRAVITY * delta

	var damp = 0
	if is_on_floor():
		damp = WALK_DAMP
	else:
		damp = AIR_DAMP

	velocity = move_and_slide(velocity, Vector2(0, -1)) * damp

	# Detect floor
	if is_on_floor():
		if falling:
			land_audio.play()
			falling = false
	else:
		falling = true



	return


func _on_Area2D_body_exited(_body: Node) -> void:
	var err = get_tree().reload_current_scene()
	if err != OK:
		print("failed to reload scene")
