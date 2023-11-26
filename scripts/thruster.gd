extends Sprite2D

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var decharge_speed := 1.0;
@export var recharge_speed := 2.0;
@export var max_charge := 5.0;

var active: bool = false: set = _set_active;
var charge := max_charge;

func _ready() -> void:
	await Global.ready;
	Global.hud.thruster_bar.set_max_value(max_charge);
	Global.hud.thruster_bar.set_value(max_charge);

func _set_active(is_active: bool) -> void:
	if is_active == active:
		return;
		
	if is_active and charge > 1.0:
		visible = true;
		anim.play("ramp_up");
		
		await anim.animation_finished;
		anim.play("flicker");
	else:
		anim.play_backwards("ramp_up");
		
		await anim.animation_finished;
		visible = false;

	active = is_active;

func _process(delta: float) -> void:
	if active:
		charge = max(0.0, charge - (delta * decharge_speed));
		if !audio_stream_player_2d.playing:
			audio_stream_player_2d.play();
	else:
		charge = min(max_charge, charge + (delta * recharge_speed));
		if audio_stream_player_2d.playing:
			audio_stream_player_2d.stop();
		
	if is_zero_approx(charge):
		active = false;
		
	Global.hud.thruster_bar.set_value(charge);
