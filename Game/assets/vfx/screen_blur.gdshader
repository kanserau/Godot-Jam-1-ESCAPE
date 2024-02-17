shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_linear_mipmap;
uniform float amount : hint_range(0.0, 5.0);
uniform vec3 color : source_color;
uniform float blend : hint_range(0.0, 1.0);

void fragment() {
	COLOR.rbg = blend * color
			+ (1.0 - blend) * textureLod(screen_texture, SCREEN_UV, amount).rbg;
}