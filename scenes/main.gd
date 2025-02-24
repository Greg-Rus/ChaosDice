extends Node2D
class_name Main

@export var die_scene : PackedScene
@export var re_rolls_count : int = 3

@onready var roll_zone : RollZone = %RollZone

func _ready():
	EventBus.die_clicked.connect(on_die_clicked)
	EventBus.re_roll_clicked.connect(do_re_roll)
	EventBus.end_turn_clicked.connect(on_end_turn)
	EventBus.on_remaining_re_rolls_changed.emit()
	spawn_dice(GameState.initial_dice_count)

		
func spawn_dice(initial_die_count : int):
	for i in initial_die_count:
		var die = die_scene.instantiate() as Die
		die.die_id = i
		roll_zone.add_die(die)
		GameState.free_dice[die.die_id] = die
	
func on_die_clicked(die : Die):
	GameState.selected_die = die
	if GameState.free_dice.has(die.die_id):
		if(GameState.legal_dice_picks.has(die.number)):
			GameState.lock_die(die)
	else:
		EventBus.locked_die_selected.emit(die)
	
func do_re_roll():
	if(GameState.re_rolls_available == 0):
		return
	GameState.re_rolls_available -= 1
	EventBus.on_remaining_re_rolls_changed.emit()
	roll_free_dice()
	
func roll_free_dice():
	for die_id in GameState.free_dice.keys():
		var die = GameState.free_dice[die_id] as Die
		die.roll()
	EventBus.dice_rolled.emit()
		
func on_end_turn():
	GameState.re_rolls_available = re_rolls_count
	EventBus.on_remaining_re_rolls_changed.emit()
	GameState.reset_locked_dice()
	roll_zone.reset_dice()
	start_new_turn()

func start_new_turn():
	EventBus.turn_start.emit()
	roll_free_dice()
	
