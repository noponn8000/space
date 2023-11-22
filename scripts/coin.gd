class_name Coin;
extends Area2D

@onready var anim := $AnimationPlayer;

@export var magnet_speed := 100.0;
@export var magnet_range := 50.0;

func _physics_process(delta: float) -> void:
	if global_position.distance_squared_to(Global.player.global_position) < magnet_range * magnet_range:
		position += global_position.direction_to(Global.player.global_position) * magnet_speed * delta;
func pick_up() -> void:
	set_deferred("monitorable", false);
	anim.play("pick_up");
