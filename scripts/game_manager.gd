extends Node

@onready var points_label: Label = %PointsLabel

var points = 0

func add_point():
	points += 1
	print(points)
	points_label.text = "Points: " + str(points)


func _on_fall_area_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		get_tree().reload_current_scene()
