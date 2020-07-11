shader_type canvas_item;

uniform vec2 screen_size;
uniform sampler2D glitch_texture;

void fragment()
{
	// vec2 uv = FRAGCOORD.xy / screen_size.xy;
	vec2 uv = SCREEN_UV; 
	vec2 block = floor(FRAGCOORD.xy / vec2(16));
	vec2 uv_noise = block / vec2(64);
	uv_noise += floor(vec2(TIME) * vec2(1234.0, 3543.0)) / vec2(64);
	
	float block_thresh = pow(fract(TIME * 1236.0453), 2.0) * 0.2;
	float line_thresh = pow(fract(TIME * 2236.0453), 3.0) * 0.7;
	
	vec2 uv_r = uv, uv_g = uv, uv_b = uv;

	// glitch some blocks and lines
	if (texture(glitch_texture, uv_noise).r < block_thresh ||
		texture(glitch_texture, vec2(uv_noise.y, 0.0)).g < line_thresh) {

		vec2 dist = (fract(uv_noise) - 0.5) * 0.3;
		uv_r += dist * 0.1;
		uv_g += dist * 0.2;
		uv_b += dist * 0.125;
	}

	COLOR.r = texture(SCREEN_TEXTURE, uv_r).r;
	COLOR.g = texture(SCREEN_TEXTURE, uv_g).g;
	COLOR.b = texture(SCREEN_TEXTURE, uv_b).b;

	// loose luma for some blocks
	if (texture(glitch_texture, uv_noise).g < block_thresh)
		COLOR.rgb = COLOR.ggg;

	// discolor block lines
	if (texture(glitch_texture, vec2(uv_noise.y, 0.0)).b * 3.5 < line_thresh)
		COLOR.rgb = vec3(0.0, dot(COLOR.rgb, vec3(1.0)), 0.0);

	// interleave lines in some blocks
	if (texture(glitch_texture, uv_noise).g * 1.5 < block_thresh ||
		texture(glitch_texture, vec2(uv_noise.y, 0.0)).g * 2.5 < line_thresh) {
		float line = fract(FRAGCOORD.y / 3.0);
		vec3 mask = vec3(3.0, 0.0, 0.0);
		if (line > 0.333)
			mask = vec3(0.0, 3.0, 0.0);
		if (line > 0.666)
			mask = vec3(0.0, 0.0, 3.0);

		COLOR.xyz *= mask;
		//COLOR.rgba = c;
	}
}