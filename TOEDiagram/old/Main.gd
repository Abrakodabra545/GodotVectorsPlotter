extends Node2D


@onready var arrow = load("res://arrow.tscn")
@onready var blackArrow = preload("res://arrow.png")
@onready var greenArrow = preload("res://greenArrow.png")
@onready var blueArrow = preload("res://blueArrow.png")
@onready var redArrow = load("res://redArrow.png")
@onready var currentColor = load("res://greenArrow.png")

var arrowLength = 1024.0
var targetLength = 0.0
var targetScale = Vector2(1.0, 0.25)
var targetRot = 0
var mainBasePos = Vector2(230, 550)
var basePos = Vector2(230, 550)
var posOfEnd = basePos
var globalScale = 1
var i = 0
var j = 0
var maxHor = 600
var maxVer = 300

var scaleHor = 1.0 
var scaleVer = 1.0

var activeU = 20
var inductiveU = 200
var emkostU = 55.0

var vhod = [20.0, 200.0, 55.0]
var vhodScale = [0.0, 0.0, 0.0]

func _ready():
		if i == 0:
			targetRot = 0
			targetLength = activeU * scaleHor
			
		elif i == 1:
			targetRot = -PI/2
			posOfEnd = posOfEnd + Vector2(-10, 0)
			targetLength = inductiveU * scaleVer
			currentColor = blueArrow
		
		elif i == 2:
			targetRot = PI/2
			targetLength = emkostU * scaleVer
			currentColor = redArrow
		
		elif i == 3:
			targetRot = (atan2((posOfEnd - mainBasePos).y, (posOfEnd - mainBasePos).x))
			targetLength = (posOfEnd - mainBasePos).length()
			posOfEnd = mainBasePos
			currentColor = blackArrow
			
		targetScale.x = targetLength/arrowLength

		
		var arrowInstanced = arrow.instantiate()
		arrowInstanced.scale = targetScale
		arrowInstanced.rotation = targetRot
		arrowInstanced.position = posOfEnd
		arrowInstanced.set_texture(currentColor)
		add_child(arrowInstanced)

		posOfEnd = Vector2(basePos.x + targetLength* cos(targetRot), basePos.y + targetLength * sin(targetRot) )
		basePos = posOfEnd
		i += 1
	
