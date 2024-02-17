shader_type canvas_item;

uniform float amount : hint_range(0.0, 5.0);
uniform vec3 color : source_color;
uniform float blend : hint_range(0.0, 1.0);

void fragment() {
	COLOR.rbg = blend * color
			+ (1.0 - blend) * texture(TEXTURE, UV, amount).rbg;
}