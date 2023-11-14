extends Panel

signal addVectorPressed
signal deleteVectorPressed

var vectorName = "Vector2"
var vectorCoord = Vector2(0.0, 0.0)
var vectorId = 0
var addView = false

@onready var nameLabel = $nameLabel
@onready var coordLabel = $coordLabel
@onready var addButton = $Button
@onready var deleteButton = $DeleteButton
func _ready():
	if addView:
		coordLabel.hide()
		addButton.show()
		deleteButton.hide()
		set_name_of_vector("Add new vector")
		nameLabel.set_text(vectorName)
	else:
			nameLabel.set_text(vectorName)
			coordLabel.set_text(str(vectorCoord * Vector2(1, -1)))
			


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
