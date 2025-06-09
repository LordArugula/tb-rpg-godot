extends Node;

## Filters the possible targets for an ability.
class_name AbilityTargetFilter;

func can_target(_actor: ActorController, _target: ActorController) -> bool:
	push_error("Function not implemented.");
	return false;

## Checks if all targets are valid.
func matches(_actor: ActorController, _targets: Array[ActorController]) -> bool:
	push_error("Function not implemented.");
	return false;
