shader_type canvas_item;

global uniform vec4 pizzaman_eye_color;
const vec4 red = vec4(1.0, 0.0, 0.0, 1.0);

void fragment() {
	vec4 input_color = texture(TEXTURE, UV);
	if(input_color == red) {
		COLOR = pizzaman_eye_color;
	}
}
