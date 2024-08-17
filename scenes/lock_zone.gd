extends Panel

@export var dieSlots : Array[Control]
var next_free_slot_index = 0

func _ready():
	EventBus.free_die_selected.connect(on_free_died_selected)
	EventBus.end_turn.connect(on_end_turn)

func getSlotByIndex(index: int) -> Control:
	return dieSlots[index]
	
func get_next_free_slot() -> Control:
	var slot = dieSlots[next_free_slot_index]
	next_free_slot_index += 1
	return slot

func _on_end_turn_button_pressed():
	EventBus.end_turn.emit()
	
func on_free_died_selected(die:Die):
	die.reparent(get_next_free_slot())
	var destination = Vector2(8, 8)
	var tween = get_tree().create_tween()
	tween.tween_property(die, "position", destination, 0.3).set_trans(Tween.TRANS_CUBIC)
	
func on_end_turn():
	next_free_slot_index = 0
