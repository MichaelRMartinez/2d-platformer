extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		var y_delta = position.y - body.position.y
		print(y_delta)
		
		if (y_delta > 2):
			print("destroy enemy")
			queue_free()
			body.jump()
		else:
			print("get hurt")
			get_tree().reload_current_scene()
