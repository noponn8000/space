class_name Player;
extends CharacterBody2D

@export var movement_speed := 100.0;
@export var acceleration := 5.0;
@export var deceleration := 5.0;

@onready var sprite := $Pivot/Sprite2D;
@onready var particles := $Pivot/GPUParticles2D;
@onready var pivot := $Pivot;
@onready var cannon := $Pivot/CannonComponent;
@onready var hurtbox: Area2D = $Hurtbox

var direction: Vector2;

func _ready() -> void:
	Global.player = self;
	
	hurtbox.hit_registered.connect(on_hit_registered);
	
func handle_input() -> void:
	direction = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	).normalized();
	
	if direction:
		pivot.rotation = Vector2.UP.angle_to(direction);
	
	if Input.is_action_just_pressed("ui_accept"):
		cannon.fire();
	
func _physics_process(delta: float) -> void:
	handle_input();
	
	if direction:
		velocity = velocity.move_toward(direction * movement_speed, acceleration);
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration);
		
	update_sprite();
	move_and_slide();

func update_sprite() -> void:
	if velocity != Vector2.ZERO:
		particles.emitting = true;
		sprite.frame = 1;
	else:
		particles.emitting = false;
		sprite.frame = 0;

func on_hit_registered(hitbox: Hitbox) -> void:
	print("Player was hit!");
