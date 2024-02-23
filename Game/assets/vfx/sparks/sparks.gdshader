shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx, unshaded;


void vertex() {
	// billboard
	mat4 __mvm = VIEW_MATRIX * mat4(INV_VIEW_MATRIX[0], INV_VIEW_MATRIX[1], INV_VIEW_MATRIX[2], MODEL_MATRIX[3]);
	__mvm = __mvm * mat4(vec4(length(MODEL_MATRIX[0].xyz), 0.0, 0.0, 0.0), vec4(0.0, length(MODEL_MATRIX[1].xyz), 0.0, 0.0), vec4(0.0, 0.0, length(MODEL_MATRIX[2].xyz), 0.0), vec4(0.0, 0.0, 0.0, 1.0));
	MODELVIEW_MATRIX = __mvm;
}

float square_dist(vec2 vec) {
	return vec.x*vec.x + vec.y*vec.y;
}

void fragment() {
	float dist = exp(-25.0 * square_dist(UV + vec2(-0.5, -0.5)));
	ALBEDO = vec3(1, 1, dist);
	ALPHA *= dist;
}