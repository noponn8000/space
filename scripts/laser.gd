class_name Laser;
extends Line2D;

@onready var hitbox: Hitbox = $Hitbox
@onready var shape: CollisionShape2D = $Hitbox/CollisionShape2D

func _ready() -> void:
	add_point(Vector2.ZERO);
	add_point(Vector2.ZERO);

func update_line(a: Vector2, b: Vector2) -> void:
	set_point_position(0, to_local(a));
	set_point_position(1, to_local(b));

	shape.shape.a = to_local(a);
	shape.shape.b = to_local(b);
