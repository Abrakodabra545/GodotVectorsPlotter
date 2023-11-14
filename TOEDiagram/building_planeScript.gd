extends Node2D


var listOfVectors = []

signal deleteAllVectors

@onready var vectorObject = load("res://vector.tscn")

func build_vector(coords, id):
	var vectorToBuild = vectorObject.instantiate()
	vectorToBuild.name = str(id)
	vectorToBuild.set_coord(coords)
	add_child(vectorToBuild)
	listOfVectors += [get_node(str(id))]


	
func delete_all():
	if listOfVectors.size() != 0:
		get_tree().call_group("vectors", "delete_this_vector")
		listOfVectors.clear()
