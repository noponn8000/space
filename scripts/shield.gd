class_name Shield
extends Hurtbox;

@onready var health: HealthManager = $HealthManager;

func _ready() -> void:
	health.health_depleted.connect(queue_free);

func register_hit(hitbox: Hitbox) -> void:
	health.change_hp(-1);
