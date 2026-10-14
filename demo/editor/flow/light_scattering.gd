extends Node3D

# PhysXFlow3D.light_scattering: a green light low in a swirling sea of ground fog,
# ringed by pillars and a leaning slab. The light glows through the fog around
# it, and the pillars, the slab and the walker cast dark shafts through that
# glow (PhysXFlow3D.scattering_shadows). The fog is one thin, cold box emitter
# over the whole floor (it feeds gently and stays down), wheeled round the light
# by smoke-free stirrers; a capsule on a spinning hub wades through it. A dim
# blue moon keeps the rest of the fog dark.
#
#   L        light scattering on / off
#   K        scattering shadows on / off
#   G        the green light on / off
#   WASD + right mouse   fly the camera

@onready var _flow: Node = $PhysXFlow3D
@onready var _label: Label = $HUD/Label
@onready var _light: Light3D = $GreenLight


func _unhandled_input(event: InputEvent) -> void:
	if not (event is InputEventKey and event.pressed and not event.echo):
		return
	match event.keycode:
		KEY_L:
			_flow.set("light_scattering", not _flow.get("light_scattering"))
		KEY_K:
			_flow.set("scattering_shadows", not _flow.get("scattering_shadows"))
		KEY_G:
			_light.visible = not _light.visible
		_:
			return
	get_viewport().set_input_as_handled()


func _process(_delta: float) -> void:
	var on := ["off", "on"]
	_label.text = "Light scattering: %s [L]   shadows: %s [K]   green light: %s [G]\nWASD + right mouse: fly   FPS %d" % [
		on[int(_flow.get("light_scattering"))], on[int(_flow.get("scattering_shadows"))], on[int(_light.visible)],
		Engine.get_frames_per_second()]
