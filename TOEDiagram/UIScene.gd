extends CanvasLayer


signal onCreateButtonPressed
signal onExitButtonPressed
signal onApplyButtonPressed

@onready var applyButton = $Control/ApplyButton
@onready var scaleEnter = $Control/ScaleEnter
@onready var listOfVector = $Control/Panel/ScrollContainer/VBoxContainer



var newScale = 1

func toggle_UI(state):
	applyButton.disabled = !state
	scaleEnter.editable = state
	for vectorPanel in listOfVector.get_children():
		vectorPanel.toggle_panel(state)

func _on_add_menu_create_button_pressed():
	onCreateButtonPressed.emit()


func _on_add_menu_exit_button_pressed():
	onExitButtonPressed.emit()


func _on_apply_button_button_up():
	onApplyButtonPressed.emit(newScale)


func _on_scale_enter_text_changed(new_text):
	newScale = float(new_text)
