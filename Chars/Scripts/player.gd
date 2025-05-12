extends CharacterBody2D
signal hit

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	hide()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handles jump if buttons are pressed.
	if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up")) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.animation = "jump"
	elif velocity.y == 0:
		$AnimatedSprite2D.animation = "stand"
		
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.name.begins_with("En"):
		print("Hit Detected "+ body.get_name())
		hide()
		hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	
func start(pos):
	velocity.x = 0
	position = pos
	show()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	hide()
	hit.emit()
