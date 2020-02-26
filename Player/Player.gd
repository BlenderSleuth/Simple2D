extends KinematicBody2D

# Tweakables
const WALK_SPEED = 50
const AIR_SPEED = 20
const GRAVITY = 1000
const JUMP_SPEED = 600

const GROUND_DAMP = 0.85
const AIR_DAMP = 0.96

# Velocity relative to world
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

## Remember: The origin of the world is in the top left, so +x is right (as usual)
## but y+ is DOWN, not up. So in order to jump UP, you need to subtract velocity in the y direction

func _physics_process(delta: float) -> void:

	# Apply keyboard input
	var move = Vector2()
	if Input.is_action_pressed('right'):
		move.x += WALK_SPEED if is_on_floor() else AIR_SPEED
	if Input.is_action_pressed('left'):
		move.x -= WALK_SPEED if is_on_floor() else AIR_SPEED

	velocity += move

	# Only add jump velocity if on the floor
	if Input.is_action_just_pressed('jump'):
		if is_on_floor():
			velocity.y -= JUMP_SPEED

	# Apply gravity
	velocity.y += GRAVITY * delta

	var dampening = GROUND_DAMP if is_on_floor() else AIR_DAMP

	velocity = move_and_slide(velocity, Vector2(0, -1))

	velocity = velocity * dampening

	return


func _on_DeathBox_exited(body: Node) -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.
