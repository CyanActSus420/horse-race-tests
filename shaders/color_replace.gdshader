shader_type canvas_item;
uniform vec4 target_color : source_color;
uniform vec4 replace_color : source_color;
uniform float tolerance : hint_range(0, 1);
//6abe30
void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	
	float dist = distance(texture_color.rgb, target_color.rgb);
	if (dist < tolerance) {
		texture_color.rgb = replace_color.rgb;
	}
	
	COLOR = texture_color;
}