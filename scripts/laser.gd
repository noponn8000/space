class_name Laser;
extends Line2D;

@onready var hitbox: Hitbox = $Hitbox
@onready var shape: CollisionShape2D = $Hitbox/CollisionShape2D
	
func update_line(a: Vector2, b: Vector2) -> void:
	add_point(to_local(a));
	add_point(to_local(b));

	shape.shape.a = to_local(a);
	shape.shape.b = to_local(b);
