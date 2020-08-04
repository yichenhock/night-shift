shader_type canvas_item; 

uniform bool shadow = false;

void fragment(){
	vec4 curr_color = texture(TEXTURE,UV); //Get current color of pixel
	
	if (shadow && curr_color.a != 0.0){
        COLOR = vec4(0.14,0.19,0.20,0.3);
    }else{
        COLOR = curr_color;
    }
	
}