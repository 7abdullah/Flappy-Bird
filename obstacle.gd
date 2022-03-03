extends Node2D

signal score

onready var piont = $Piont

const speed = 200

func _physics_process(delta):
	position.x += -speed * delta
	if global_position.x <= -200:
		queue_free()
		

func _on_column_body_entered(body):
	if body is Player:
		
		#print("player het wall")
		if body.has_method("die"):
			body.die()


func _on_Area2D_body_exited(body):
	if body is Player:
		emit_signal("score")
		
		
