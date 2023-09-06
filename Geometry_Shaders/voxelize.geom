#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform float step = 2.0;
uniform mat4 modelViewProjectionMatrix;

void pinta(vec3 v) {
	gl_Position = modelViewProjectionMatrix * vec4(v, 1.0);
	EmitVertex();
}

void pintarCub(vec3 u) {
	int x = int(step/2);
	vec3 v;
	gfrontColor = vec4(0.7, 0.7, 0.7, 1);
	
	// Cara frontal
	v = u + vec3(-x, x, x); pinta(v);
	v = u + vec3(-x, -x, x); pinta(v);
	v = u + vec3(x, x, x); pinta(v);
	v = u + vec3(x, -x, x); pinta(v);
	// Cara dreta
	v = u + vec3(x, x, -x); pinta(v);
	v = u + vec3(x, -x, -x); pinta(v);
	// Cara darrera
	v = u + vec3(-x, x, -x); pinta(v);
	v = u + vec3(-x, -x, -x); pinta(v);
	// Cara esquerra
	v = u + vec3(-x, x, x); pinta(v);
	v = u + vec3(-x, -x, x); pinta(v);
	EndPrimitive();
	
	// Cara a dalt
	v = u + vec3(-x, x, -x); pinta(v);
	v = u + vec3(-x, x, x); pinta(v);
	v = u + vec3(x, x, -x); pinta(v);
	v = u + vec3(x, x, x); pinta(v);
	EndPrimitive();
	
	// Cara de baix
	v = u + vec3(-x, -x, x); pinta(v);
	v = u + vec3(-x, -x, -x); pinta(v);
	v = u + vec3(x, -x, x); pinta(v);
	v = u + vec3(x, -x, -x); pinta(v);
	EndPrimitive();
}

void main( void ) {
	vec4 B = (gl_in[0].gl_Position + gl_in[1].gl_Position + gl_in[2].gl_Position)/3;
	int i = int(B.x/step)*step, j = int(B.y/step)*step, k = int(B.z/step)*step;
	
	pintarCub(vec3(i, j, k));
}
