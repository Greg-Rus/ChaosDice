extends Node
class_name BaseRuleCondition

signal rule_status_changed(is_met : bool)

@export var is_triggered : bool = false:
	set(new_value):
		is_triggered = process_result(new_value)
	get:
		return is_triggered

@export var negate : bool = false

func test() -> bool:
	printerr("Using base rule condition class. Alwasy returns FALSE!")
	return false

func process_result(result : bool) -> bool:
	if(negate):
		return not result
	return result
