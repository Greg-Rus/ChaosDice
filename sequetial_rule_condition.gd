extends BaseRuleCondition
class_name SequentialRuleCondition

var children : Array[BaseRuleCondition]

func _ready():
	children.assign(get_children()) 
	
func test():
	var result = false
	for rule in children:
		result = rule.test()
		if(result == false):
			break
	is_triggered = result
