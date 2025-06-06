extends Node3D;

class_name ActorController;

@export
var faction: StringName;

@onready
var abilities: AbilitySet = $AbilitySet;

@onready
var stats: StatSet = $StatSet;

@onready
var animation_player: AnimationPlayer = $AnimationPlayer;

var current_ability: AbilityController;

func start_turn():
	turn_started.emit(self);

	var ability = await ability_selected;
	if (ability == null):
		return ;
	
	current_ability = ability;
	print("%s selected %s" % [self.name, ability.name]);
	
	var targets: Array[ActorController] = [];
	targets.assign(await targets_selected);
	
	print("%s used %s on %s" % [self.name, ability.name, targets]);
	
	activate_ability(ability, targets);

	turn_ended.emit(self);
	current_ability = null;
	
	pass


func activate_ability(ability: AbilityController, targets: Array[ActorController]):
	ability.activate(self, targets);
	ability.apply(self, targets);
	ability.resolve(self, targets);

	pass


func play_animation(animation: StringName):
	if (animation.is_empty()):
		return;

	animation_player.play(animation);
	pass


func take_damage(amount: float):
	var health = stats.get_stat(&"Health");
	stats.set_stat(&"Health", health.value - amount);

	damage_taken.emit(self, amount);

	pass


func take_healing(amount: float):
	var health = stats.get_stat(&"Health");
	stats.set_stat(&"Health", health.value + amount);

	healing_taken.emit(self, amount);

	pass


signal turn_started(actor: ActorController);
signal turn_ended(actor: ActorController);

signal damage_taken(actor: ActorController, amount: float);
signal healing_taken(actor: ActorController, amount: float);

signal ability_selected(ability: AbilityController);
signal targets_selected(targets: Array[ActorController]);
