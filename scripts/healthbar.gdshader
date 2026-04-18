shader_type canvas_item;

global uniform float healthbar_clip;
global uniform sampler2D healthbar_dead;

void fragment() {
	vec4 input_color = texture(healthbar_dead, UV);
	if(UV.x > healthbar_clip) {
		COLOR = input_color;
	}
}