extends Node2D
class_name Main

var free_dice = {}
var locked_dice = {}

@export var die_scene : PackedScene
@export var initial_die_count : int
@export var re_rolls_count : int = 3

@onready var roll_zone : RollZone = %RollZone

var re_rolls_remaining = re_rolls_count

func _ready():
	EventBus.die_clicked.connect(on_die_clicked)
	EventBus.re_roll.connect(on_re_roll)
	EventBus.end_turn.connect(on_end_turn)
	EventBus.on_remaining_re_rolls_changed.emit(re_rolls_remaining)
	
	for i in initial_die_count:
		var die = die_scene.instantiate() as Die
		die.die_id = i
		roll_zone.add_die(die)
		free_dice[i] = die
	
func on_die_clicked(die : Die):
	if free_dice.has(die.die_id):
		lock_die(die)
		EventBus.free_die_selected.emit(die)
	else:
		EventBus.locked_die_selected.emit(die)
	
func lock_die(die : Die):
	free_dice.erase(die.die_id)
	locked_dice[die.die_id] = die
	
func on_re_roll():
	if(re_rolls_remaining == 0):
		return
	re_rolls_remaining -= 1
	EventBus.on_remaining_re_rolls_changed.emit(re_rolls_remaining)
	
	for die_id in free_dice.keys():
		var die = free_dice[die_id] as Die
		die.roll()
		
func on_end_turn():
	re_rolls_remaining = re_rolls_count
	for die_id in locked_dice.keys():
		var die = locked_dice[die_id] as Die
		free_dice[die.die_id] = die
	locked_dice.clear()
	roll_zone.reset_dice(free_dice.values())
	EventBus.re_roll.emit()
