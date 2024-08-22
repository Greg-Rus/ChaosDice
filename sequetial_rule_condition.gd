extends BaseRuleCondition
class_name SequentialRuleCondition

var children : Array[BaseRuleCondition]

func _ready():
	children.assign(get_children()) 
	#EventBus.die_locked.connect(on_die_locked)
	#
#func on_die_locked(die):
	#test()
	#print("Sequential result is: " + str(is_triggered))
	
func test():
	var result = false
	for rule in children:
		result = rule.test()
		if(result == false):
			break
	is_triggered = result
	print("Sequential result is: " + str(is_triggered))
	
	
