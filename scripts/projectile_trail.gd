class_name ProjectileTrail;
extends Line2D;

@export var point_limit := 50;

func _ready() -> void:
	top_level = true;
	
func _physics_process(delta: float) -> void:
	add_point(get_parent().global_position);
	
	if points.size() > point_limit:
		remove_point(0);
