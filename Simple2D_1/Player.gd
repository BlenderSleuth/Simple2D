extends KinematicBody2D



# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# print("Hello World")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

const WALK_SPEED = 200
const GRAVITY = 300
const JUMP_SPEED = 20

var jumping = false

func _physics_process(delta: float) -> void:

	velocity.x = 0
	if Input.is_action_pressed('right'):
		velocity.x = WALK_SPEED
	if Input.is_action_pressed('left'):
		velocity.x = -WALK_SPEED

	if Input.is_action_pressed('jump'):
		if not jumping:
			velocity.y -= JUMP_SPEED
		# velocity.y = velocity.y - JUMP_SPEED

	velocity.y += GRAVITY * delta

	#move_and_collide(velocity * delta)
	velocity = move_and_slide(velocity)


	return
