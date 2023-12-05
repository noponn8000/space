class_name Coin;
extends Area2D

@onready var anim := $AnimationPlayer;
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var magnet_speed := 100.0;
@export var magnet_range := 50.0;
@export var despawn_time := 10.0;

func _ready() -> void:
	get_tree().create_timer(despawn_time).timeout.connect(queue_free);

func _physics_process(delta: float) -> void:
	if not Global.player:
		return;

	if global_position.distance_squared_to(Global.player.global_position) < magnet_range * magnet_range:
		position += global_position.direction_to(Global.player.global_position) * magnet_speed * delta;
		
func pick_up() -> void:
	audio_stream_player_2d.pitch_scale = randf_range(0.8, 1.2);
	audio_stream_player_2d.play();
	
	set_deferred("monitorable", false);
	anim.play("pick_up");
	
	await audio_stream_player_2d.finished;
	queue_free();
