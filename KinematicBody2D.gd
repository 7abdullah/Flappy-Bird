extends RigidBody2D


class_name Player
export var Flap_Forse = -200

onready var Animator = $AnimatedSprite
onready var hit = $Hit
onready var wing = $Wing

const MAX_ROTANT = -30.0

var started = false
var alive = true

func _physics_process(delta):
	if Input.is_action_just_pressed("flap") && alive:
		if !started: 
			start()
		flap()
	if rotation_degrees <= MAX_ROTANT:
		angular_velocity = 0	
		rotation_degrees = MAX_ROTANT
	if linear_velocity.y > 0:
		if rotation_degrees <= 90:
			angular_velocity = 3
		if !rotation_degrees <= 90:
			angular_velocity = 0	
		
		
func start():
	if started: return
	started = true
	gravity_scale = 5.0
	Animator.play("move")	
func flap():
	linear_velocity.y = Flap_Forse
	angular_velocity = -8.0	
	wing.play()

signal died	
func die():
	if !alive: return
	alive = false
	Animator.stop()
	hit.play()
	emit_signal("died")
	
		
