class_name ShieldSpinner;
extends Node2D

@export var shield_scene := load("res://scenes/shield.tscn");
@export var shield_count := 3;
@export var shield_offset := 50.0;
@export var rotation_speed := 10.0;

var shields := [];

func _ready() -> void:
	var d_theta = TAU / shield_count;
	for i in shield_count:
		var shield = shield_scene.instantiate();
		add_child(shield);
		
		shield.global_position = global_position + Vector2(0, shield_offset).rotated(i * d_theta);
		shield.rotation = i * d_theta;
		shields.append(shield);

func _physics_process(delta: float) -> void:
	rotation += rotation_speed * delta;
