extends Control
class_name Die

@export var faceTextures : Array[Texture]
@export var dotColors : Array[Color]
@export var number : int
@export var die_id : int

@onready var faceSprite : TextureRect = %FaceSprite
@onready var dotSprite : TextureRect = %DotSprite

func _ready():
	roll()
	
func roll():
	_rollNumber()
	_updateGraphics()
	
func _rollNumber():
	number = randi_range(1,6)
	
func _updateGraphics():
	faceSprite.texture = faceTextures[number - 1]
	dotSprite.self_modulate = dotColors[number - 1]


func _on_gui_input(event):
	if event is InputEventMouseButton:
		var mouseEvent = event as InputEventMouseButton
		if mouseEvent.pressed == true:
			EventBus.die_clicked.emit(self)
