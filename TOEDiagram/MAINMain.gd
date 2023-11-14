extends Node2D


var listOfVectorsName = []
var listOfVectorsPosition = []
var listofVectorsObject = []

@onready var UIListOfVectors = $UI/Control/Panel/ScrollContainer/VBoxContainer
@onready var vectorPanel = load("res://vector_panel.tscn")
@onready var addMeny = $UI/Control/AddMenu
@onready var buildingPlane = $BuildingPlane
@onready var xMaxLabel = $xMaxLabel
@onready var yMaxLabel = $yMaxLabel
@onready var UI = $UI


var scaleOfVector = 1
var defaultXMax = 370
var defaultYMax = 270
var numbersAfterDotInMaxCoords = 0.001

func _ready():
	refreshMaxCoord(scaleOfVector)
	refreshListOfVectors()
		
		

func refreshListOfVectors():
	buildingPlane.delete_all()
	
	for child in UIListOfVectors.get_children():
		child.queue_free()
		
	for currentVector in listOfVectorsName.size():
		var vectorToAdd = vectorPanel.instantiate()

		vectorToAdd.set_name_of_vector(listOfVectorsName[currentVector])
		vectorToAdd.set_coord_of_vector(listOfVectorsPosition[currentVector])
		vectorToAdd.deleteVectorPressed.connect(deleteVector.bind())
		vectorToAdd.set_vector_id(currentVector)
		UIListOfVectors.add_child(vectorToAdd)
		buildingPlane.build_vector(listOfVectorsPosition[currentVector] * scaleOfVector, currentVector)
		
	var vectorToAdd = vectorPanel.instantiate()
	vectorToAdd.set_panel_to_addview()
	vectorToAdd.addVectorPressed.connect(_on_add_new_vector_button_up.bind())
	UIListOfVectors.add_child(vectorToAdd)

func refreshMaxCoord(currentScale):
	xMaxLabel.set_text(str(snapped((defaultXMax / currentScale), numbersAfterDotInMaxCoords)))
	yMaxLabel.set_text(str(snapped((defaultYMax / currentScale), numbersAfterDotInMaxCoords)))
	
func _on_add_new_vector_button_up():
	addMeny.show()
	UI.toggle_UI(false)
	
	
func deleteVector(id):
	listOfVectorsName.remove_at(id)
	listOfVectorsPosition.remove_at(id)
	
	refreshListOfVectors()
	
func add_new_vector():
	var nameOfVectorToAdd = [""]
	var coordOfVectorToAdd = [Vector2(0, 0)]
	
	nameOfVectorToAdd[0] = addMeny.get_new_vector_name()
	coordOfVectorToAdd[0] = addMeny.get_new_vector_coords()
	
	listOfVectorsName +=  nameOfVectorToAdd
	listOfVectorsPosition += coordOfVectorToAdd
	refreshListOfVectors()

func _on_ui_on_create_button_pressed():
	addMeny.hide()
	add_new_vector()
	UI.toggle_UI(true)
	addMeny.refreshInputFields()


func _on_ui_on_exit_button_pressed():
	addMeny.hide()
	addMeny.refreshInputFields()
	UI.toggle_UI(true)


func _on_ui_on_apply_button_pressed(newScale):
	scaleOfVector = newScale
	refreshMaxCoord(newScale)
	refreshListOfVectors()
