class_name FlashComponent;
extends Node

@export var color_gradient: GradientTexture1D;

var flashing := false;
var flash_timer := 0.0;
var flash_duration := 0.0;
var flash_speed := 0.0;

func flash(duration: float, speed: float) -> void:
	flashing = true;
	flash_timer = 0.0;
	flash_speed = speed;
	flash_duration = duration;

func _process(delta: float) -> void:
	if flashing:
		owner.modulate = color_gradient.gradient.sample(fmod(flash_timer * flash_speed, 1.0));
		
		flash_timer += delta;
		
		if flash_timer > flash_duration:
			flashing = false;
			owner.modulate = Color.WHITE;
