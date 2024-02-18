shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx;

uniform sampler2D FireTexture;
uniform vec2 NoiseScaling = vec2(1.000000, 1.000000);
uniform vec2 FlameVector = vec2(0.000000, 1.000000);
uniform sampler2D NoiseTexture;
uniform float NoiseRatio : hint_range(0, 1);

void vertex() {
	mat4 __mvm = VIEW_MATRIX * mat4(INV_VIEW_MATRIX[0], INV_VIEW_MATRIX[1], INV_VIEW_MATRIX[2], MODEL_MATRIX[3]);
	MODELVIEW_MATRIX = __mvm * mat4(vec4(length(MODEL_MATRIX[0].xyz), 0.0, 0.0, 0.0), vec4(0.0, length(MODEL_MATRIX[1].xyz), 0.0, 0.0), vec4(0.0, 0.0, length(MODEL_MATRIX[2].xyz), 0.0), vec4(0.0, 0.0, 0.0, 1.0));
}

void fragment() {
	vec4 fire = texture(FireTexture, UV);
	vec4 n_out12p0 = texture(NoiseTexture, vec2(TIME) * FlameVector + UV * NoiseScaling);
	vec4 mixed = mix(fire, fire * n_out12p0, NoiseRatio) * COLOR;
	ALBEDO = mixed.rgb;
	ALPHA = mixed.a;
}