extends Node2D

@export var laser_a: LaserTurret;
@export var laser_b: LaserTurret;

@onready var laser_line: Laser = $Laser;

func _physics_process(delta: float) -> void:
	laser_a.look_at(laser_b.global_position);
	laser_b.look_at(laser_a.global_position);
	
	laser_line.update_line(laser_a.global_position, laser_b.global_position);
