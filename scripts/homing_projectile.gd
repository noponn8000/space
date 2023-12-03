class_name HomingProjectile;
extends Projectile;

@export var target_group_name := "enemies";

var target: Node2D;
var steer := Vector2.ZERO;

func _ready() -> void:
	target = find_closest_target();

func _physics_process(delta: float) -> void:
	if target != null and target.is_in_group(target_group_name):
		var target_direction: Vector2 = global_position.direction_to(target.global_position);
		var distance_weighting: float = clamp(
			1 + 1 / global_position.distance_to(target.global_position),
			1.0,
			5.0
		);
		steer = (target_direction - velocity.normalized()) * attrs.homing_strength * distance_weighting;
	
	speed = max(0.0, speed - attrs.deceleration * delta);
	velocity = (direction * speed +  2 * steer) * delta;
	
	if velocity == Vector2.ZERO:
		despawn_timer += delta;
		
		if despawn_timer > attrs.linger:
			explode();
	else:
		despawn_timer = 0.0;
	
	var collision := move_and_collide(velocity);

	if collision:
		if collision.get_collider() is RigidBody2D:
			collision.get_collider().apply_central_impulse(-collision.get_normal() * attrs.push_force);
			
		bounce_counter += 1;
		
		if bounce_counter <= attrs.bounces:
			direction = direction.bounce(collision.get_normal());
		else:
			explode();

func find_closest_target() -> Node2D:
	var targets := get_tree().get_nodes_in_group(target_group_name);
	
	var closest_target: Node2D = null;
	var shortest_dist_sq := 10e9;
	for target in targets:
		var dist_sq = global_position.distance_squared_to(target.global_position);
		
		if dist_sq < pow(attrs.homing_range, 2) and dist_sq < shortest_dist_sq:
			closest_target = target;
			shortest_dist_sq = dist_sq;
	
	return closest_target;
	
