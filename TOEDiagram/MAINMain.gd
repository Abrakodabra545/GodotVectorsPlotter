extends Node2D


var listOfVectorsName = []
var listOfVectorsPosition = []

@onready var UIListOfVectors = $UI/ScrollContainer/VBoxContainer
@onready var vectorPanel = load("res://vector_panel.tscn")
@onready var addMeny = $UI/AddMenu

func _ready():
	refreshListOfVectors()
		
		

func refreshListOfVectors():
	for child in UIListOfVectors.get_children():
		child.queue_free()
		
	for currentVector in listOfVectorsName.size():
		var vectorToAdd = vectorPanel.instantiate()

		vectorToAdd.set_name_of_vector(listOfVectorsName[currentVector])
		vectorToAdd.set_coord_of_vector(listOfVectorsPosition[currentVector])
		vectorToAdd.deleteVectorPressed.connect(deleteVector.bind())
		vectorToAdd.vectorId = currentVector
		UIListOfVectors.add_child(vectorToAdd)
		
	var vectorToAdd = vectorPanel.instantiate()
	vectorToAdd.set_panel_to_addview()
	vectorToAdd.addVectorPressed.connect(_on_add_new_vector_button_up.bind())
	UIListOfVectors.add_child(vectorToAdd)

func _on_add_new_vector_button_up():
	addMeny.show()
	
func deleteVector(id):
	listOfVectorsName.remove_at(id)
	listOfVectorsPosition.remove_at(id)
	refreshListOfVectors()

func _on_add_menu_create_button_pressed():
	addMeny.hide()
	add_new_vector()
	addMeny.refreshInputFields()
	
func add_new_vector():
	var nameOfVectorToAdd = [""]
	var coordOfVectorToAdd = [Vector2(0, 0)]
	
	nameOfVectorToAdd[0] = addMeny.get_new_vector_name()
	coordOfVectorToAdd[0] = addMeny.get_new_vector_coords()
	
	listOfVectorsName +=  nameOfVectorToAdd
	listOfVectorsPosition += coordOfVectorToAdd
	refreshListOfVectors()


func _on_add_menu_exit_button_pressed():
	addMeny.hide()
	addMeny.refreshInputFields()
