extends Sprite2D

@export var active := true: set = set_active;
@export var next_frame := true;
@export var fps := 5.0;

@onready var flash_component: FlashComponent = $FlashComponent

func _process(delta: float) -> void:
	if active and next_frame:
		frame = randi_range(0, 7);

		next_frame = false;
		get_tree().create_timer(1 / fps).timeout.connect(
			func(): next_frame = true;
		);
	elif not active:
		frame = 8;

func set_active(is_active: bool) -> void:
	if active == is_active:
		return;

	if not is_active:
		flash_component.flash(1.0, 5.0);
		
	active = is_active;
