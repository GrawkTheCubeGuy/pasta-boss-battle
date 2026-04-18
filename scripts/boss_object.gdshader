shader_type canvas_item;

void fragment() {
	vec4 input_color = texture(TEXTURE, UV);
	if(input_color == vec4(1, 1, 1, 1)) {
		COLOR = vec4(0, 0, 0, 0);
	}
}

