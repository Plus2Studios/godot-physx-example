extends Node3D

# PhysXFlow3D.light_scattering: three blocks standing in a sea of ground fog,
# each lit by a colored light beside it that glows in the fog around it (and
# casts the blocks' shadows through it). The fog
# is one thin, cold box emitter over the whole floor (it feeds gently and stays
# down), churned by smoke-free stirrers scattered across it; the blocks are
# solids the fog flows around. A little of Godot's own volumetric fog lets the
# lights glow in the air above it too.
#
#   L        light scattering on / off
#   1 2 3    yellow / red / green light on / off
#   WASD + right mouse   fly the camera

@onready var _flow: Node = $PhysXFlow3D
@onready var _label: Label = $HUD/Label
@onready var _lights: Array[Light3D] = [$YellowLight, $RedLight, $GreenLight]


func _unhandled_input(event: InputEvent) -> void:
	if not (event is InputEventKey and event.pressed and not event.echo):
		return
	match event.keycode:
		KEY_L:
			_flow.set("light_scattering", not _flow.get("light_scattering"))
		KEY_1, KEY_2, KEY_3:
			var light := _lights[event.keycode - KEY_1]
			light.visible = not light.visible
		_:
			return
	get_viewport().set_input_as_handled()


func _process(_delta: float) -> void:
	var on := ["off", "on"]
	_label.text = "Light scattering: %s  [L]\nLights: yellow %s [1]  red %s [2]  green %s [3]\nWASD + right mouse: fly   FPS %d" % [
		on[int(_flow.get("light_scattering"))], on[int(_lights[0].visible)], on[int(_lights[1].visible)], on[int(_lights[2].visible)],
		Engine.get_frames_per_second()]
