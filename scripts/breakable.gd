class_name Breakable;
extends StaticBody2D

@onready var hurtbox := $Hurtbox
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var particles: GPUParticles2D = $GPUParticles2D
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	hurtbox.hit_registered.connect(_on_hit_registered);

func _on_hit_registered(_hitbox: Hitbox) -> void:
	sprite.visible = false;
	collision_shape_2d.set_deferred("disabled", true);
	hurtbox.set_deferred("monitorable", false);

	particles.restart();
