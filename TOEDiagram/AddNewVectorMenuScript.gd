extends Panel

@onready var xInput = $xInput
@onready var yInput = $yInput
@onready var nameInput = $nameInput


var newName = "Vector2"
var newXPos = 0.0
var newYPos = 0.0 

signal createButtonPressed
signal exitButtonPressed


func get_new_vector_name():
	return newName
func get_new_vector_coords():
	return Vector2(newXPos, newYPos)


func refreshInputFields():
	xInput.clear()
	yInput.clear()
	nameInput.clear()


func _on_name_input_text_changed(new_text):
	newName = new_text


func _on_x_input_text_changed(new_text):
	newXPos = float(new_text)


func _on_y_input_text_changed(new_text):
	newYPos = float(new_text)


func _on_create_button_button_up():
	createButtonPressed.emit()


func _on_exit_button_button_up():
	exitButtonPressed.emit()
