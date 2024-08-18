extends Node

#UI Input
signal die_clicked(die)
signal re_roll_clicked
signal end_turn_clicked
#UI Update
signal on_remaining_re_rolls_changed(re_roll_count : int)
#Logic
signal locked_die_selected(die)
signal turn_start
signal dice_rolled
signal die_locked(die)
