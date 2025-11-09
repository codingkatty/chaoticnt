extends CharacterBody2D
@onready var player = $blubby

const SPEED = 350.0
const JUMP_VELOCITY = -600.0

var on_pendulum = null
var cling_pos = Vector2.ZERO

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or on_pendulum):
		if on_pendulum:
			unbind()
		on_pendulum = null
		velocity.y = JUMP_VELOCITY
	elif on_pendulum:
		global_position = on_pendulum.global_position + cling_pos


	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if direction == 1:
			player.flip_h = 0
		else:
			player.flip_h = 1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# player animations
	if on_pendulum:
		set_anim("hold")
	elif not is_on_floor() or on_pendulum:
		if abs(velocity.x) > 0:
			set_anim("jump_walk")
		else:
			set_anim("jump")
	elif velocity.x == 0:
		set_anim("idle")
	else:
		set_anim("walk")

func set_anim(animation):
	if player.animation != animation:
		player.play(animation)

func unbind() -> void:
	if on_pendulum.name == "ball1":
		on_pendulum.get_parent().m1 -= 20
	elif on_pendulum.name == "ball2":
		on_pendulum.get_parent().m2 -= 20
	on_pendulum = null

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("pendulum") and not (on_pendulum or is_on_floor()):
		on_pendulum = area
		if area.name == "ball1":
			area.get_parent().m1 += 20
		elif area.name == "ball2":
			area.get_parent().m2 += 20
		cling_pos = global_position - area.global_position


func _on_killzone(body: Node2D) -> void:
	if body == self:
		call_deferred("reload_scene")

func reload_scene():
	get_tree().reload_current_scene()
