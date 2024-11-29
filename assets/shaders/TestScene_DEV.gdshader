shader_type canvas_item;

vec2 noise(vec2 uv){
	uv = vec2(dot(uv, vec2(127.1, 311.7)), dot(uv, vec2(269.5, 183.3)));
	return fract(sin(uv) * 43758.5453123) - 0.5;
}

void fragment() {
	vec2 uv = UV;
	COLOR = texture(TEXTURE, uv + noise(uv));
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
