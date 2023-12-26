extends Node2D

signal addMenuActivated
signal addMenuDisActivated
signal toggleTextFieldById
signal deleteAllTextFields


var listOfVectorsName = []
var listOfVectorsPosition = []
var listofVectorsObject = []
var listOfTextfieldsPos = []

@onready var UIListOfVectors = $UI/Control/Panel/ScrollContainer/VBoxContainer
@onready var vectorPanel = load("res://vector_panel.tscn")
@onready var textField = load("res://TextDRAGNDROPobject.tscn")
@onready var addMeny = $UI/Control/AddMenu
@onready var buildingPlane = $BuildingPlane
@onready var xMaxLabel = $xMaxLabel
@onready var yMaxLabel = $yMaxLabel
@onready var UI = $UI
@onready var camera = $Camera2D


var scaleOfVector = 1
var defaultXMax = 370
var defaultYMax = 270
var numbersAfterDotInMaxCoords = 0.001

func _ready():
	refreshMaxCoord(scaleOfVector)
	refreshListOfVectors()
	camera.toggleTextFieldFollowing.connect(toggleNameFieldById.bind())
		

func refreshListOfVectors():           # Обновить список векторов
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

func refreshNameFields():
	emit_signal("deleteAllTextFields")
	for nameField in listOfTextfieldsPos.size():
		add_name_field(nameField)
	

func refreshMaxCoord(currentScale):          # Обновить надписи масштаба
	xMaxLabel.set_text(str(snapped((defaultXMax / currentScale), numbersAfterDotInMaxCoords)))
	yMaxLabel.set_text(str(snapped((defaultYMax / currentScale), numbersAfterDotInMaxCoords)))
	
func _on_add_new_vector_button_up():         # "ДОБАВИТЬ" "НАЖАЛИ" на кнопку
	addMeny.show()
	UI.toggle_UI(false)
	emit_signal("addMenuActivated")
	
func deleteVector(id):                    # "УДАЛИТЬ" вектор
	listOfVectorsName.remove_at(id)
	listOfVectorsPosition.remove_at(id)
	listOfTextfieldsPos.remove_at(id)
	refreshNameFields()
	refreshListOfVectors()
	
func add_name_field(id):                               #"ДОБАВИТЬ" ТЕКСТполе
	var nameFieldToAdd = textField.instantiate()
	nameFieldToAdd._set_textfield(listOfVectorsName[id])
	nameFieldToAdd.position = listOfTextfieldsPos[id]
	nameFieldToAdd.updatePositionByID.connect(updatePositonOfTextFieldByID.bind())
	nameFieldToAdd.textFieldID = id
	add_child(nameFieldToAdd)
	
	
func add_new_vector():                     # "ДОБАВИТЬ" вектор
	var nameOfVectorToAdd = [""]
	var coordOfVectorToAdd = [Vector2(0, 0)]
	
	nameOfVectorToAdd[0] = addMeny.get_new_vector_name()
	coordOfVectorToAdd[0] = addMeny.get_new_vector_coords()
	
	listOfVectorsName +=  nameOfVectorToAdd
	listOfVectorsPosition += coordOfVectorToAdd
	refreshListOfVectors()

func _on_ui_on_create_button_pressed():         # "СОЗДАТЬ" 
	addMeny.hide()
	add_new_vector()
	UI.toggle_UI(true)
	listOfTextfieldsPos += [Vector2(0, 0)]
	refreshNameFields()
	addMeny.refreshInputFields()
	emit_signal("addMenuDisActivated")


func _on_ui_on_exit_button_pressed():          # "КРЕСТИК"
	addMeny.hide()
	addMeny.refreshInputFields()
	UI.toggle_UI(true)
	emit_signal("addMenuDisActivated")


func _on_ui_on_apply_button_pressed(newScale):      #  "ПРИМЕНИТЬ"
	scaleOfVector = newScale
	refreshMaxCoord(newScale)
	refreshListOfVectors()

func toggleNameFieldById(id, state):
	emit_signal("toggleTextFieldById", id, state)
	
func updatePositonOfTextFieldByID(id, newPostion):
	listOfTextfieldsPos[id] = newPostion
	
