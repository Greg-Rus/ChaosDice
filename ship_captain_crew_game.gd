extends Node

@export var initial_die_count = 5
@export var re_rolls_count : int = 3

@onready var has_ship : BaseRuleCondition = $OnDiceLockedTirgger/ShipCaptainCrewValues/Has_6
@onready var has_captain : BaseRuleCondition = $OnDiceLockedTirgger/ShipCaptainCrewValues/Has_5
@onready var has_crew : BaseRuleCondition = $OnDiceLockedTirgger/ShipCaptainCrewValues/Has_4

func _ready():
	GameState.initial_dice_count = initial_die_count
	GameState.re_rolls_available = re_rolls_count
	GameState.update_legal_dice_picks([6])
	EventBus.die_locked.connect(on_die_locked)
	EventBus.turn_start.connect(on_new_turn)
	
func on_die_locked(die):
	if(has_ship.is_triggered):
		GameState.update_legal_dice_picks([5])
	if(has_captain.is_triggered):
		GameState.update_legal_dice_picks([4])
	if(has_crew.is_triggered):
		GameState.update_legal_dice_picks([1,2,3,4,5,6])
		

func on_new_turn():
	GameState.update_legal_dice_picks([6])
