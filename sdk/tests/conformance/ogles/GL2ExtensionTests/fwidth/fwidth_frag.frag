
/*
Copyright (c) 2019 The Khronos Group Inc.
Use of this source code is governed by an MIT-style license that can be
found in the LICENSE.txt file.
*/


#ifdef GL_ES
#extension GL_OES_standard_derivatives : enable
precision mediump float;
#endif

// setting a boundary for cases where screen sizes may exceed the precision
// of the arithmetic used.
#define SAFETY_BOUND 500.0

// Macro to scale/bias the range of output.  If input is [-1.0, 1.0], maps to [0.5, 1.0]..  
// Accounts for precision errors magnified by derivative operation.
#define REDUCE_RANGE(A) ((A) + 3.0) / 4.0


varying vec2 vertXY;

uniform float viewportwidth;
uniform float viewportheight;

void main (void)
{
	const float M_PI = 3.14159265358979323846;
	float func;
	float funcfwidth;

#ifdef GL_OES_standard_derivatives
	// fwidth of average of horizontal and vertical sine waves with periods of 128 pixels, scaled to go from -1 to +1
	func = 0.5 * (sin(fract(gl_FragCoord.x / 128.0) * (2.0 * M_PI)) + sin(fract(gl_FragCoord.y / 128.0) * (2.0 * M_PI)));
	funcfwidth = REDUCE_RANGE((128.0 / (2.0 * M_PI)) * fwidth(func));
#else
        funcfwidth = 0.5;
#endif

	if( (gl_FragCoord.x < SAFETY_BOUND) && (gl_FragCoord.y < SAFETY_BOUND) )
	{
		gl_FragColor = vec4(funcfwidth, funcfwidth, funcfwidth, 1.0);
	}
	else discard;
}

