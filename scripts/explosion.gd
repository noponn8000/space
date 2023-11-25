extends Hitbox

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var particles: GPUParticles2D = $GPUParticles2D
@export var size := 50.0;
@export var expansion_time := 0.5;

func _ready() -> void:
	super._ready();
	explode();
	
func explode() -> void:
	particles.restart();
	Global.camera.shake(10, 10, 20);
	
	var tween = get_tree().create_tween();
	tween.tween_property(collision_shape, "scale", Vector2.ONE * size, expansion_time).set_trans(Tween.TRANS_CUBIC);
	
	get_tree().create_timer(0.5).timeout.connect(queue_free);
