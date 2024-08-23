extends Node

var legal_dice_picks = [1,2,3,4,5,6]
var free_dice = {}
var locked_dice = {}
var selected_die : Die
var re_rolls_available : int
var initial_dice_count : int

func get_locked_die_values() -> Array[int]:
	var dice :Array[Die]
	dice.assign(locked_dice.values())
	var numbers : Array[int]
	numbers.assign(dice.map(func(die): return die.number))
	return numbers
	
func update_legal_dice_picks(dice_picks : Array[int]):
	legal_dice_picks = dice_picks
	
func lock_die(die : Die):
	free_dice.erase(die.die_id)
	locked_dice[die.die_id] = die
	EventBus.die_locked.emit(die)
	
func reset_locked_dice():
	for die_id in locked_dice.keys():
		var die = locked_dice[die_id] as Die
		free_dice[die.die_id] = die
	locked_dice.clear()
