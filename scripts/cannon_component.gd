class_name CannonComponent;
extends Node2D

@export var projectile_scene: PackedScene;
@export var cooldown := 0.2;

var can_shoot := true;

func fire() -> void:
	if not can_shoot:
		return;
	can_shoot = false;
		
	var new_projectile = projectile_scene.instantiate();
	new_projectile.direction = Vector2.UP.rotated(global_rotation);
	new_projectile.global_position = self.global_position;
	get_tree().root.add_child.call_deferred(new_projectile);
	
	get_tree().create_timer(cooldown).timeout.connect(func(): can_shoot = true);
