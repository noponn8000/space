extends CharacterBody2D

enum States { Idle, Spin, Thrust }

@onready var hurtbox: Area2D = $Hurtbox;
@onready var death_particles: GPUParticles2D = $DeathParticles;
@onready var collision_shape: CollisionShape2D = $CollisionShape2D;
@onready var enemy_drop_manager: Node2D = $EnemyDropManager;
@onready var sprite := $Sprite2D;

@export var rotation_speed := 10.0;
@export var movement_speed := 50.0;
@export var spin_time := 1.0;
@export var thrust_time := 0.5;

var state := States.Idle;
var rotation_direction := 1;

func _ready() -> void:
	start_spin();
	
	hurtbox.hit_registered.connect(_on_hit_registered);

func _physics_process(delta: float) -> void:
	if state == States.Idle:
		velocity = Vector2.ZERO;
		rotation += rotation_direction * rotation_speed / 5 * delta;
	elif state == States.Spin:
		velocity = Vector2.ZERO;
		rotation += rotation_direction * rotation_speed * delta;
	elif state == States.Thrust:
		velocity = transform.x * movement_speed;
		
	var collision := move_and_collide(velocity * delta);
	if collision:
		transform.x = -transform.x

func _on_hit_registered(hitbox: Hitbox) -> void:
	die();
	
func start_spin() -> void:
	sprite.frame = 0;
	state = States.Spin;
	
	get_tree().create_timer(spin_time).timeout.connect(start_thrust);
	
func start_thrust() -> void:
	sprite.frame = 1;
	state = States.Thrust;
	
	get_tree().create_timer(thrust_time).timeout.connect(stop_thrust);
	
func stop_thrust() -> void:
	sprite.frame = 0;
	state = States.Idle;
	
	get_tree().create_timer(2.0).timeout.connect(start_spin);
	
func die() -> void:
	set_physics_process(false);
	
	sprite.visible = false;
	death_particles.emitting = true;
	collision_shape.set_deferred("disabled", true);
	hurtbox.set_deferred("monitorable", false);
	enemy_drop_manager.drop();
	
	get_tree().create_timer(1.0).timeout.connect(queue_free);
