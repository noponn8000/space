extends CharacterBody2D

@export var fire_interval := 1.0;
@export var drift_interval := 2.0;
@export var movement_speed := 10.0;
@export var rotation_speed := PI / 2;
@export var firing := true;

@onready var cannons := $Pivot/Cannons.get_children();
@onready var pivot := $Pivot;
@onready var hurtbox: Area2D = $Hurtbox
@onready var death_particles: GPUParticles2D = $DeathParticles
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var enemy_drop_manager: Node2D = $EnemyDropManager

var direction := Vector2.ZERO;

func _ready() -> void:
	change_direction();
	fire();
	
	hurtbox.hit_registered.connect(_on_hit_registered);
	
func change_direction() -> void:
	direction = Vector2.UP.rotated(randf_range(0, TAU));
	get_tree().create_timer(drift_interval).timeout.connect(
		change_direction
	);

func fire() -> void:
	if not firing:
		return;
		
	for cannon in cannons:
		cannon.fire();
	
	get_tree().create_timer(fire_interval).timeout.connect(
		fire
	);

func _physics_process(delta: float) -> void:
	velocity = direction * movement_speed;
	pivot.rotation += rotation_speed * delta;
	
	move_and_slide();

func _on_hit_registered(hitbox: Hitbox) -> void:
	die();

func die() -> void:
	death_particles.emitting = true;
	pivot.visible = false;
	firing = false;
	collision_shape.set_deferred("disabled", true);
	hurtbox.set_deferred("monitorable", false);
	enemy_drop_manager.drop();
	
	get_tree().create_timer(1.0).timeout.connect(queue_free);
