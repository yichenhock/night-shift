/*
 * MIT License
 * Copyright © Etienne 'Eethe' Orlhac
 * 07/08/2015
 *
 * Permission is hereby granted, free of charge, to any person obtaining 
 * a copy of this software and associated documentation files (the “Software”), 
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense, 
 * and/or sell copies of the Software, and to permit persons to whom the Software 
 * is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 * 
 * The Software is provided “as is”, without warranty of any kind, 
 * express or implied, including but not limited to the warranties of merchantability, 
 * fitness for a particular purpose and noninfringement. In no event shall the authors 
 * or copyright holders be liable for any claim, damages or other liability, whether in an 
 * action of contract, tort or otherwise, arising from, out of or in connection with 
 * the software or the use or other dealings in the Software.
 */
shader_type canvas_item;
uniform float AMPLITUDE = .1;
uniform float SPEED = 5.0;

vec4 rgbShift( in vec2 p , in vec4 shift, in sampler2D tex) {
    shift *= 2.0*shift.w - 1.0;
    vec2 rs = vec2(shift.x,-shift.y);
    vec2 gs = vec2(shift.y,-shift.z);
    vec2 bs = vec2(shift.z,-shift.x);

    float r = texture(tex, p+rs).x;
    float g = texture(tex, p+gs).y;
    float b = texture(tex, p+bs).z;

    return vec4(r,g,b,1.0);
}

float rand(in vec2 n) { 
	return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

// replace with noise texture for better performance (probably) - azdcf
vec4 rgbnoise(in vec2 p) {
	return vec4( vec3(
		rand(p+183.234),
		rand(p+32.28),
		rand(p+161.837)
	) * rand(p), 1);
}

vec4 vec4pow( in vec4 v, in float p ) {
    // Don't touch alpha (w), we use it to choose the direction of the shift
    // and we don't want it to go in one direction more often than the other
    return vec4(pow(v.x,p),pow(v.y,p),pow(v.z,p),v.w); 
}

//void mainImage( out vec4 fragColor, in vec2 fragCoord )
//{
void fragment() {
    vec4 c = vec4(0.0,0.0,0.0,1.0);

    // Elevating shift values to some high power (between 8 and 16 looks good)
    // helps make the stuttering look more sudden
    vec4 shift = vec4pow(rgbnoise(vec2(SPEED*TIME,2.0*SPEED*TIME/25.0 )),8.0)*vec4(AMPLITUDE,AMPLITUDE,AMPLITUDE,1.0);

    c += rgbShift(SCREEN_UV, shift, SCREEN_TEXTURE);
	// fix transparency, and saturation for some reason
	c.a = texture(SCREEN_TEXTURE, SCREEN_UV).a;

	COLOR = c;
}