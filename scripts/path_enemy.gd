class_name PathEnemy;
extends PathFollow2D;

@export var speed := 50.0;
@export var direction_change_delay := 0.5;
@export var moving := true;

@export_range(-1, 1, 2) var direction = 1;

func _physics_process(delta: float) -> void:
	if moving:
		progress += direction * speed * delta;

		if progress_ratio == 1.0 or progress_ratio == 0.0:
			moving = false;
			get_tree().create_timer(direction_change_delay).timeout.connect(
				func(): direction = -direction; moving = true;
		);
