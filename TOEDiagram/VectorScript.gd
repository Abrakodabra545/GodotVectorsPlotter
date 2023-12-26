extends Node2D

var vectorCoord = Vector2(0, 0)
var vectorWidth = 2.0
var arrowScale = 0.025
@onready var arrow = load("res://arrow.tscn")

func _ready():
	queue_redraw()
	add_to_group("vectors")
	var arrowPictureToAdd = arrow.instantiate()
	arrowPictureToAdd.position = vectorCoord
	arrowPictureToAdd.rotation = vectorCoord.angle() + PI/2
	arrowPictureToAdd.scale = Vector2(1, 1) * arrowScale
	add_child(arrowPictureToAdd)
	

func delete_this_vector():
	queue_free()

func _draw():
	draw_line(Vector2(0, 0), vectorCoord, Color.BLACK, vectorWidth, true)
	
func set_coord(coordForThisVector):
	vectorCoord = coordForThisVector
func get_coord():
	return vectorCoord
	
func delete_current_vector():
	queue_free()
