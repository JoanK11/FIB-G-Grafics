#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
in vec3 vnormal[];

out vec4 gfrontColor;

const float speed = 0.5;
uniform float time;
uniform mat4 modelViewProjectionMatrix;

void main(void) {
	vec3 n = (vnormal[0] + vnormal[1] + vnormal[2])/3;
	vec3 trans = speed * time * n;

	for (int i = 0; i < 3; i++) {
		gfrontColor = vfrontColor[i];
		gl_Position = modelViewProjectionMatrix * vec4((trans + gl_in[i].gl_Position.xyz), 1.0);
		EmitVertex();
	}
    EndPrimitive();
}
