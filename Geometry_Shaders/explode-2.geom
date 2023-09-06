#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
in vec3 vnormal[];

out vec4 gfrontColor;

const float speed = 1.2;
const float angSpeed = 8.0;
uniform float time;
uniform mat4 modelViewProjectionMatrix;

void main(void) {
	vec3 n = (vnormal[0] + vnormal[1] + vnormal[2])/3;
	vec3 T = speed * time * n;
	float scale = angSpeed * time;
	mat3 Rz = mat3(vec3(cos(scale), sin(scale), 0), vec3(-sin(scale), cos(scale), 0), vec3(0, 0, 1)); 
	vec3 BT = (gl_in[0].gl_Position.xyz + gl_in[1].gl_Position.xyz + gl_in[2].gl_Position.xyz)/3;
          
	for (int i = 0; i < 3; i++) {
		gfrontColor = vfrontColor[i];
		vec3 V = gl_in[i].gl_Position.xyz - BT; // Traslladem al centre
		V *= Rz; // Rotem sobre l'eix Z
		V += BT +T; // Tornem el vèrtex a la seva posició original i el Traslladem
		gl_Position = modelViewProjectionMatrix * vec4(V, 1.0);
		EmitVertex();
	}
    EndPrimitive();
}
