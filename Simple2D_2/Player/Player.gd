extends KinematicBody2D

class_name Player

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# print("Hello World")
	pass # Replace with function body.


# tweakables
const WALK_SPEED = 50
const AIR_SPEED = 20
const GRAVITY = 1000
const JUMP_SPEED = 600

const WALK_DAMP = 0.85
const AIR_DAMP = 0.96

func _physics_process(delta: float) -> void:

	# velocity.x = 0
	if Input.is_action_pressed('right'):
		if is_on_floor():
			velocity.x += WALK_SPEED
		else:
			velocity.x += AIR_SPEED
	if Input.is_action_pressed('left'):
		if is_on_floor():
			velocity.x += -WALK_SPEED
		else:
			velocity.x += -AIR_SPEED
	if Input.is_action_pressed('jump'):
		if is_on_floor():
			velocity.y -= JUMP_SPEED

	velocity.y += GRAVITY * delta

	var damp = 0
	if is_on_floor():
		damp = WALK_DAMP
	else:
		damp = AIR_DAMP

	velocity = move_and_slide(velocity, Vector2(0, -1)) * damp


	return


func _on_Area2D_body_exited(_body: Node) -> void:
	get_tree().reload_current_scene()
