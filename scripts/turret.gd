class_name Turret;
extends StaticBody2D

@export var enabled := true: set = set_enabled;
@export var range := 300.0;
@export var target_group_name := "player";

@onready var pivot: Node2D = $Pivot
@onready var cannons := $Pivot/Cannons.get_children();

var rotation_timer = 0.0;

func _physics_process(delta: float) -> void:
	var closest_target := get_closest_target();
	
	if closest_target:
		look_at(closest_target.global_position);

		for cannon in cannons:
			cannon.fire();
	
func get_closest_target() -> Node2D:
	var targets := get_tree().get_nodes_in_group(target_group_name);
	
	var closest_target: Node2D = null;
	var shortest_dist_sq := 10e9;
	for target in targets:
		var dist_sq = global_position.distance_squared_to(target.global_position);
		
		if dist_sq < range * range and dist_sq < shortest_dist_sq:
			closest_target = target;
			shortest_dist_sq = dist_sq;
			
	return closest_target;
	
func set_enabled(is_enabled: bool) -> void:
	set_physics_process(is_enabled);
	enabled = is_enabled;
