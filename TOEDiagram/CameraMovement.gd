extends Camera2D

signal toggleTextFieldFollowing

var mouseDownPos = Vector2.ZERO
var previosCameraPosition = Vector2.ZERO
var cameraEndPoint = Vector2.ZERO
var mousePressed = false
var movesDisabled = false
var addMenuIsActive = false
var cameraSensitivity = 1.4
var textfieldToMoveID = 0
var detectictingRadius = 60

func _process(delta):
	if mousePressed and !movesDisabled and !addMenuIsActive:
		position = previosCameraPosition + (mouseDownPos - get_viewport().get_mouse_position()) * (1/zoom.length()) * cameraSensitivity

func _toggle_textfield(id, state):
	emit_signal("toggleTextFieldFollowing", id, state)
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.button_mask == 1:
				_save_pos()
				mousePressed = event.is_pressed()
				if _get_id_of_textfield_if_in() != -1:
					_toggle_textfield(_get_id_of_textfield_if_in(), true)
					movesDisabled = true
				else:
					movesDisabled = false
			elif event.button_mask == 0:
				mousePressed = event.is_pressed()
				_toggle_textfield(_get_id_of_textfield_if_in(), false)
		elif event.button_index == 4:
			if zoom.x < 1.8:
				zoom += Vector2(0.1, 0.1)
		elif event.button_index == 5:
			if zoom.x > 0.7:
				zoom -= Vector2(0.1, 0.1)



func _save_pos():
	previosCameraPosition = position
	mouseDownPos = get_viewport().get_mouse_position()

func _get_id_of_textfield_if_in():
	for textfieldPositon in get_parent().listOfTextfieldsPos.size():
		if (get_parent().listOfTextfieldsPos[textfieldPositon] - get_global_mouse_position()).length() < detectictingRadius:
			return textfieldPositon
	return -1
func _on_main_add_menu_activated():
	addMenuIsActive = true

func _on_main_add_menu_dis_activated():
		addMenuIsActive = false
