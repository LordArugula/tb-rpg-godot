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
	if (health.value <= 0): 
		knocked_out.emit(self);
		pass

	pass


func take_healing(amount: float):
	var health = stats.get_stat(&"Health");
	health.value += amount;

	healing_taken.emit(self, amount);

	pass


signal damage_taken(actor: ActorController, amount: float);
signal healing_taken(actor: ActorController, amount: float);
signal knocked_out(actor: ActorController);
