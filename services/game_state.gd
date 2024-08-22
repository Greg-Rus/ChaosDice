extends Node

var legal_dice_picks = [1,2,3,4,5,6]
var free_dice = {}
var locked_dice = {}
var selected_die : Die
var re_rolls_available : int

func get_locked_die_values() -> Array[int]:
	var dice :Array[Die]
	dice.assign(locked_dice.values())
	var numbers : Array[int]
	numbers.assign(dice.map(func(die): return die.number))
	return numbers
	
func update_gegal_dice_picks(dice_picks : Array[int]):
	legal_dice_picks = dice_picks
