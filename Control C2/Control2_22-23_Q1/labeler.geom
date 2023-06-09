#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

out vec2 st;

uniform float size = 0.07;
uniform float depth = -0.01;

void drawRectangle(vec4 C, float w) {
	vec4 v1 = vec4(C.x - size, C.y + size, C.z + depth, 1.0); // A dalt a l'esquerra
	vec4 v2 = vec4(C.x - size, C.y - size, C.z + depth, 1.0); // A baix a l'esquerra
	vec4 v3 = vec4(C.x + size, C.y + size, C.z + depth, 1.0); // A dalt a la dreta
	vec4 v4 = vec4(C.x + size, C.y - size, C.z + depth, 1.0); // A baix a la dreta
	
	gfrontColor = vec4(1); // Definim un color qualsevol
	gl_Position = v1*w;
	st = vec2(0, 7);
	EmitVertex();
	
	gl_Position = v2*w;
	st = vec2(0, 0);
	EmitVertex();
	
	gl_Position = v3*w;
	st = vec2(7, 7);
	EmitVertex();
	
	gl_Position = v4*w;
	st = vec2(7, 0);
	EmitVertex();
	
	EndPrimitive();
}

void main( void ) {
	vec4 C = (gl_in[0].gl_Position + gl_in[1].gl_Position + gl_in[2].gl_Position)/3; // Centre en Clipping
	float w = C.w;
	C /= w; // Centre en NDC
	
	for (int i = 0 ; i < 3 ; i++) {
		gfrontColor = vfrontColor[i];
		gl_Position = gl_in[i].gl_Position;
		st = vec2(-1, -1);
		EmitVertex();
	}
	EndPrimitive();
	
	drawRectangle(C, w);
}
