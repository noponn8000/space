extends Projectile

@export var shatter_projectile_scene: PackedScene;
@export var shatter_count := 5;
@export var shatter_offset := 10.0;

func explode() -> void:
	spawn_shatter_projectiles();
		
	queue_free();

func spawn_shatter_projectiles() -> void:
	var d_theta := TAU / shatter_count;
	for i in range(shatter_count):
		var projectile_position = global_position + Vector2.ONE.rotated(i * d_theta) * shatter_offset;
		
		var s_projectile := shatter_projectile_scene.instantiate();
		s_projectile.global_position = projectile_position;
		s_projectile.direction = Vector2.ONE.rotated(i * d_theta);
		
		get_tree().root.call_deferred("add_child", s_projectile);
