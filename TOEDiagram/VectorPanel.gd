extends Panel

signal addVectorPressed
signal deleteVectorPressed
signal addNameFieldPressed

var vectorName = "Vector2"
var vectorCoord = Vector2(0.0, 0.0)
var vectorId = 0
var addView = false
var isPanelDisabled = false

@onready var nameLabel = $nameLabel
@onready var coordLabel = $coordLabel
@onready var addButton = $Button
@onready var deleteButton = $DeleteButton
@onready var addNameFieldButton = $NameButton


func _ready():
	if addView:
		coordLabel.hide()
		addButton.show()
		deleteButton.hide()
		addNameFieldButton.hide()
		set_name_of_vector("Add new vector")
		nameLabel.set_text(vectorName)
	else:
			nameLabel.set_text(vectorName)
			coordLabel.set_text(str(vectorCoord * Vector2(1, -1)))
			

func toggle_panel(state):
	addButton.disabled = !state
	deleteButton.disabled = !state
	addNameFieldButton.disabled = !state
func get_state():
	return isPanelDisabled

func set_panel_to_addview():
	addView = true

func set_vector_id(id):
	vectorId = id
func get_vector_id():
	return vectorId

func set_name_of_vector(nameOfThisVector):
	vectorName = nameOfThisVector
func set_coord_of_vector(coordsOfThisVector):
	vectorCoord = coordsOfThisVector
	
func get_coord_of_vector():
	return vectorCoord
func get_name_of_vector():
	return vectorName


func _on_button_button_up():
	addVectorPressed.emit()


func _on_delete_button_button_up():
	deleteVectorPressed.emit(vectorId)
	queue_free()

func _on_name_button_button_up():
	addNameFieldPressed.emit(vectorName)
