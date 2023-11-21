class_name Projectile;
extends Hitbox;

@export var visibility_notifier: VisibleOnScreenNotifier2D;
@export var attrs: ProjectileAttributes = preload("res://resources/default_projectile_attributes.tres");
@export var hitbox: Hitbox;

var direction := Vector2.UP;
var hit_counter := 0;

func _ready() -> void:
	super._ready();
	
	visibility_notifier.screen_exited.connect(queue_free);
	body_entered.connect(_on_body_entered);
	
	if hitbox:
		hitbox.hit_registered.connect(_on_hit_registered);

func _process(delta: float) -> void:
	position += direction * attrs.speed * delta;

func _on_body_entered(body: Node2D) -> void:
	queue_free();

func _on_hit_registered(_hurtbox: Hurtbox) -> void:
	hit_counter += 1;
	if hit_counter >= attrs.piercing:
		queue_free();
