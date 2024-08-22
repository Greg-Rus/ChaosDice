extends Control
class_name RollZone

@export var slot_scene : PackedScene

@onready var die_grid : Control = %Dice
@onready var re_rolls_number_label : Label = $Label
var slots : Array[Control]

func _ready():
	EventBus.on_remaining_re_rolls_changed.connect(on_re_rolls_changed)
		
func add_die(die : Die):
	var slot = slot_scene.instantiate()
	die_grid.add_child(slot)
	slots.append(slot)
	slot.add_child(die)
	
	
func reset_dice():
	for i in GameState.free_dice.size():
		var die = GameState.free_dice[i] as Die
		die.reparent(slots[i], false)

func _on_re_roll_button_pressed():
	EventBus.re_roll_clicked.emit()

func on_re_rolls_changed():
	re_rolls_number_label.text = "Remaining Rerolls: " + str(GameState.re_rolls_available)
