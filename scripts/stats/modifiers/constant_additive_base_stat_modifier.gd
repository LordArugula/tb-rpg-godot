extends StatModifier;

@export
var value: float;

func modify(_base_value: float, _current_value: float) -> StatValues:
	return StatValues.new(
        _base_value + value,
        _current_value + value,
    );
