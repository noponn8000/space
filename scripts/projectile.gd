class_name Projectile;
extends CharacterBody2D;

@export var visibility_notifier: VisibleOnScreenNotifier2D;
@export var attrs: ProjectileAttributes = preload("res://resources/default_projectile_attributes.tres");
@export var hitbox: Hitbox;

var direction := Vector2.UP;
var hit_counter := 0;
var bounce_counter := 0;
var speed := attrs.speed;

func _ready() -> void:
	visibility_notifier.screen_exited.connect(queue_free);
	
	if hitbox:
		hitbox.hit_registered.connect(_on_hit_registered);
		
	direction = direction.rotated(randf_range(-attrs.spread, attrs.spread));

func _process(delta: float) -> void:
	velocity = direction * speed * delta;
	speed = max(0.0, speed - attrs.deceleration * delta);
	
	var collision := move_and_collide(velocity);
	
	if collision:
		bounce_counter += 1;
		
		if bounce_counter <= attrs.bounces:
			direction = direction.bounce(collision.get_normal());
		else:
			queue_free();

func _on_hit_registered(_hurtbox: Hurtbox) -> void:
	hit_counter += 1;
	if hit_counter >= attrs.piercing:
		queue_free();