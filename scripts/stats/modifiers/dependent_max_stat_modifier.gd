extends StatModifier;

@export
var stat: StatController;

func modify(_base_value: float, _current_value: float) -> StatValues:
	return StatValues.new(
        min(_base_value, stat.value),
        min(_current_value, stat.value)
    );
