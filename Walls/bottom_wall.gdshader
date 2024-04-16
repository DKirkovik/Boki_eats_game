shader_type canvas_item;

uniform sampler2D distortionTexture;


void fragment() {
	vec4 textureColor = texture(TEXTURE, vec2(sin(UV.x + TIME),UV.y));
	COLOR = textureColor;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
