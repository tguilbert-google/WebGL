
/*
Copyright (c) 2019 The Khronos Group Inc.
Use of this source code is governed by an MIT-style license that can be
found in the LICENSE.txt file.
*/


attribute vec4 gtf_Vertex;
uniform mat4 gtf_ModelViewProjectionMatrix;
varying vec4 color;

#define ERROR_EPSILON 0.1

void main (void)
{
	float x;
	// Declare a 4 by 4 matrix with unique elements.
	mat4 a = mat4(   1.0,    2.0,     4.0,     8.0,   // 1.0  16.0  256.0  4096.0
	                16.0,   32.0,    64.0,   128.0,   // 2.0  32.0  512.0  8192.0
	               256.0,  512.0,  1024.0,  2048.0,   // 4.0  64.0 1024.0 16384.0
	              4096.0, 8192.0, 16384.0, 32768.0);  // 8.0 128.0 2048.0 32768.0

	// Copy the matrix to another non-const matrix.
	mat4 b = a;

	// Check each element of the copy.
	bool elms = true;
	if(b[0][0] !=     1.0) elms = false;
	if(b[0][1] !=     2.0) elms = false;
	if(b[0][2] !=     4.0) elms = false;
	if(b[0][3] !=     8.0) elms = false;
	if(b[1][0] !=    16.0) elms = false;
	if(b[1][1] !=    32.0) elms = false;
	if(b[1][2] !=    64.0) elms = false;
	if(b[1][3] !=   128.0) elms = false;
	if(b[2][0] !=   256.0) elms = false;
	if(b[2][1] !=   512.0) elms = false;
	if(b[2][2] !=  1024.0) elms = false;
	if(b[2][3] !=  2048.0) elms = false;
	if(b[3][0] !=  4096.0) elms = false;
	if(b[3][1] !=  8192.0) elms = false;
	if(b[3][2] != 16384.0) elms = false;
	if(b[3][3] != 32768.0) elms = false;

	// Add up each row of the copy.
	bool rows = true;
	x = b[0][0] + b[1][0] + b[2][0] + b[3][0];
	if(x < 4369.0-ERROR_EPSILON || x > 4369.0+ERROR_EPSILON) rows = false;
	x = b[0][1] + b[1][1] + b[2][1] + b[3][1];
	if(x < 8738.0-ERROR_EPSILON || x > 8738.0+ERROR_EPSILON) rows = false;
	x = b[0][2] + b[1][2] + b[2][2] + b[3][2];
	if(x < 17476.0-ERROR_EPSILON || x > 17476.0+ERROR_EPSILON) rows = false;
	x = b[0][3] + b[1][3] + b[2][3] + b[3][3];
	if(x < 34952.0-ERROR_EPSILON || x > 34952.0+ERROR_EPSILON) rows = false;

	// Add up each column of the copy.
	bool cols = true;
	x = b[0][0] + b[0][1] + b[0][2] + b[0][3];
	if(x < 15.0-ERROR_EPSILON || x > 15.0+ERROR_EPSILON) cols = false;
	x = b[1][0] + b[1][1] + b[1][2] + b[1][3];
	if(x < 240.0-ERROR_EPSILON || x > 240.0+ERROR_EPSILON) cols = false;
	x = b[2][0] + b[2][1] + b[2][2] + b[2][3];
	if(x < 3840.0-ERROR_EPSILON || x > 3840.0+ERROR_EPSILON) cols = false;
	x = b[3][0] + b[3][1] + b[3][2] + b[3][3];
	if(x < 61440.0-ERROR_EPSILON || x > 61440.0+ERROR_EPSILON) cols = false;

	// Check if all of the operations were successful.
	float gray = elms && rows && cols ? 1.0 : 0.0;

	// Assign the varying variable color.
	color = vec4(gray, gray, gray, 1.0);

	// Transform the vertex position.
	gl_Position = gtf_ModelViewProjectionMatrix * gtf_Vertex;
}

