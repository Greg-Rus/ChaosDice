extends BaseRuleCondition
class_name SpecificLockedDiceCondition

@export var specific_locked_dice : Array[int]

func test() -> bool:
	var result_found : bool = false

	var dice_values = GameState.get_locked_die_values()
	for value in specific_locked_dice:
		var index = dice_values.find(value, 0)
		if(index < 0):
			is_triggered = false
			result_found = true
			break
		else:
			dice_values[index] = -1
	if(not result_found):
		is_triggered = true
	
	return is_triggered
