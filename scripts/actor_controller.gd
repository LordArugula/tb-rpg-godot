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

func start_turn():
	turn_started.emit(self);
	pass


func end_turn():
	turn_ended.emit(self);
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
	health.value -= amount;

	damage_taken.emit(self, amount);

	pass


func take_healing(amount: float):
	var health = stats.get_stat(&"Health");
	health.value += amount;

	healing_taken.emit(self, amount);

	pass


signal turn_started(actor: ActorController);
signal turn_ended(actor: ActorController);

signal damage_taken(actor: ActorController, amount: float);
signal healing_taken(actor: ActorController, amount: float);
