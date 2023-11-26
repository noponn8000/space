class_name CannonComponent;
extends Node2D;

@export var projectile_scene: PackedScene;
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var can_shoot := true;

signal fired;

func fire() -> void:
	if not can_shoot or Global.item_manager.get_current_item_quantity() == 0:
		return;
	can_shoot = false;

	var new_projectile = projectile_scene.instantiate();
	new_projectile.direction = Vector2.UP.rotated(global_rotation);
	new_projectile.global_position = self.global_position;
	get_tree().root.add_child.call_deferred(new_projectile);
	
	get_tree().create_timer(new_projectile.attrs.cooldown).timeout.connect(func(): can_shoot = true);
	
	audio_stream_player_2d.stream = new_projectile.attrs.shoot_sfx;
	audio_stream_player_2d.play();
	
	fired.emit();

func _item_changed(item: int) -> void:
	projectile_scene = Global.item_library[item as ItemType.Type];
