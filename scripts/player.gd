class_name Player;
extends CharacterBody2D

@export var base_movement_speed := 100.0;
@export var thruster_speed := 200.0;
@export var acceleration := 5.0;
@export var deceleration := 5.0;
@export var push_force := 80.0;

@onready var sprite := $Pivot/Sprite2D;
@onready var particles := $Pivot/GPUParticles2D;
@onready var pivot := $Pivot;
@onready var cannon := $Pivot/CannonComponent;
@onready var hurtbox: Area2D = $Hurtbox
@onready var thruster: Sprite2D = $Pivot/Thruster
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D;
@onready var visibility_notifier := $VisibleOnScreenNotifier2D;

var direction: Vector2;
var movement_speed := base_movement_speed;

func _ready() -> void:
	Global.player = self;
	
	hurtbox.hit_registered.connect(on_hit_registered);
	
func handle_input() -> void:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized();
	
	if direction:
		pivot.rotation = Vector2.UP.angle_to(direction);
	
	if Input.is_action_pressed("shoot"):
		cannon.fire();
		
	if Input.is_action_pressed("thruster"):
		thruster.active = true;
		movement_speed = thruster_speed;
	else:
		thruster.active = false;
		movement_speed = base_movement_speed;
	
func _physics_process(delta: float) -> void:
	handle_input();
	
	if direction:
		velocity = velocity.move_toward(direction * movement_speed, acceleration);
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration);
		
	update_sprite();
	update_sound();
	move_and_slide();
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)

func update_sound() -> void:
	if direction != Vector2.ZERO and !audio_stream_player_2d.playing:
		audio_stream_player_2d.play();
	elif direction == Vector2.ZERO and audio_stream_player_2d.playing:
		audio_stream_player_2d.stop();

func update_sprite() -> void:
	if velocity != Vector2.ZERO:
		particles.emitting = true;
		sprite.frame = 1;
	else:
		particles.emitting = false;
		sprite.frame = 0;

func on_hit_registered(hitbox: Hitbox) -> void:
	print("Player was hit!");
