extends CharacterBody2D

enum STATES { IDLE, CHASE }

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var pivot: Node2D = $Pivot;
@onready var hurtbox: Area2D = $Hurtbox
@onready var death_particles: GPUParticles2D = $DeathParticles

@export var chase_radius := 500.0;
@export var acceleration := 50.0;
@export var movement_speed := 50.0;

var state = STATES.IDLE;

func _ready() -> void:
	hurtbox.hit_registered.connect(_on_hit_registered);

func _physics_process(delta: float) -> void:
	if global_position.distance_squared_to(Global.player.global_position) < chase_radius * chase_radius:
		state = STATES.CHASE;
	else:
		state = STATES.IDLE;
		
	if state == STATES.IDLE:
		velocity = velocity.move_toward(Vector2.ZERO, acceleration);
		animation_player.play("RESET");
	elif state == STATES.CHASE:
		animation_player.play("wakawaka");
		velocity = velocity.move_toward(
			global_position.direction_to(Global.player.global_position) * movement_speed,
			acceleration
	);
	
	pivot.rotation = snapped(Vector2.UP.angle_to(velocity.normalized()), PI / 4);
	
	move_and_slide();

func _on_hit_registered(hitbox: Hitbox) -> void:
	die();
	
func die() -> void:
	death_particles.emitting = true;
	pivot.visible = false;
	
	get_tree().create_timer(1.0).timeout.connect(queue_free);
