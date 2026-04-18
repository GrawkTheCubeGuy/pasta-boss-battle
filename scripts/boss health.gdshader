shader_type canvas_item;

//0.6228
global uniform float boss_healthbar;


void fragment() {
	float health_amount = 0.2336 + boss_healthbar;
	vec4 input_color = texture(TEXTURE, UV);
	if (input_color == vec4(1, 0, 0, 1) && UV.x < 0.8564 && UV.x > health_amount) {
		COLOR = vec4(0, 0, 0, 1);
	}
	
}

