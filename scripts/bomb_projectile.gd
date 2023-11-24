extends Projectile

@export var explosion_scene: PackedScene = load("res://scenes/explosion.tscn");

func _on_hit_registered(_hurtbox: Hurtbox) -> void:
	explode();
	
func explode() -> void:
	visible = false;
	var explosion = explosion_scene.instantiate();
	
	explosion.global_position = global_position;
	get_tree().root.call_deferred("add_child", explosion);
	
	queue_free();
