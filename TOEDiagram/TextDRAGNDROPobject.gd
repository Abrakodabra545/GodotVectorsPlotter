extends Label

signal updatePositionByID

var isFollowing = false
var ableToMove = true
var textFieldID = 0
var textToSet = ""
var compensationVector = -Vector2(20,20)

func _ready():
	text = textToSet
	get_parent().toggleTextFieldById.connect(_toggle_isfollowing.bind())
	get_parent().deleteAllTextFields.connect(_delete_this_textfield.bind())
	get_parent().addMenuDisActivated.connect(addMenuDisactivated.bind())
	get_parent().addMenuActivated.connect(addMenuActivated.bind())

func _process(delta):
	if isFollowing and ableToMove:
		emit_signal("updatePositionByID", textFieldID, position)
		_follow_mouse()

func addMenuActivated():
	ableToMove = false
	
func addMenuDisactivated():
	ableToMove = true
	
func _set_textfield(inputText):
	textToSet = inputText

func _follow_mouse():
	position = get_global_mouse_position() + compensationVector

func _toggle_isfollowing(id, state):
	if textFieldID == id:
		isFollowing = state
		
func _delete_this_textfield():
	queue_free()

func _get_pos():
	return position
