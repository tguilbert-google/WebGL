
/*
Copyright (c) 2019 The Khronos Group Inc.
Use of this source code is governed by an MIT-style license that can be
found in the LICENSE.txt file.
*/


#ifdef GL_ES
precision mediump float;
#endif
//
// vec3arrayindirect_frag.frag: Fragment shader solid color
// The vec3 values are determined at runtime.
//
//

uniform vec3 lightPosition[2];
varying vec4  color;

void main(void)
{
     int i;

     gl_FragColor = vec4(0.0);

	 /*
		// No indirect indexing in fragment shaders
     for (i = 0; i < 2; i++)
     {
          gl_FragColor += vec4(lightPosition[i], 0.0);
     }
	 */
	 gl_FragColor += vec4(lightPosition[0], 0.0);
	 gl_FragColor += vec4(lightPosition[1], 0.0);

     gl_FragColor /= 2.0;
}
