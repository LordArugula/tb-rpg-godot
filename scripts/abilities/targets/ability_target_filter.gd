extends Node;

## Filters the possible targets for an ability.
class_name AbilityTargetFilter;


## Filters the possible targets for an ability.
func apply(_actor: ActorController, _actors: Array[ActorController]) -> Array[ActorController]:
    push_error("Function not implemented.");
    return [];

## Checks if all targets are valid.
func matches(_actor: ActorController, _actors: Array[ActorController]) -> bool:
    push_error("Function not implemented.");
    return false;
