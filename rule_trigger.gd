extends Node
class_name RuleTrigger

@export var TriggerType: Constants.RuleTriggerType
@export var RuleConditions: Array[BaseRuleCondition]

func _ready():
	RuleConditions.assign(get_children())
	
	match TriggerType:
		Constants.RuleTriggerType.DICE_LOCKED:
			EventBus.die_locked.connect(func (die): trigger())
		Constants.RuleTriggerType.REROLL:
			EventBus.dice_rolled.connect(func (die): trigger())
		Constants.RuleTriggerType.TURN_END:
			EventBus.turn_end.connect(func (die): trigger())
			
func trigger():
	for child in RuleConditions:
		child.test()
