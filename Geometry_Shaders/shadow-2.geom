#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;
uniform vec3 boundingBoxMax;
uniform vec3 boundingBoxMin;

void main( void ) {
	// Triangle original sense il·luminació
	for (int i = 0; i < 3 ; i++) {
		gfrontColor = vfrontColor[i];
		gl_Position = modelViewProjectionMatrix * gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();
    
    // Triangle que representa l'ombra
    for (int i = 0; i < 3; ++i) {
    	gfrontColor = vec4(0);
    	gl_Position = gl_in[i].gl_Position;
    	gl_Position.y = boundingBoxMin.y;
    	gl_Position = modelViewProjectionMatrix * gl_Position;
    	EmitVertex();
	}
	EndPrimitive();
	
	// Plataforma cian
	if (gl_PrimitiveIDIn == 0) {
		vec4 C = vec4((boundingBoxMax.x + boundingBoxMin.x)/2, boundingBoxMin.y - 0.01, (boundingBoxMax.z + boundingBoxMin.z)/2, 1.0);
		float R = distance(boundingBoxMax, boundingBoxMin)/2;
		
		gl_Position = modelViewProjectionMatrix * (C + vec4(-R, 0, -R, 0));
		gfrontColor = vec4(0, 1, 1, 1);
		EmitVertex();
		gl_Position = modelViewProjectionMatrix * (C + vec4(-R, 0, R, 0));
		EmitVertex();
		gl_Position = modelViewProjectionMatrix * (C + vec4(R, 0, -R, 0));
		EmitVertex();
		gl_Position = modelViewProjectionMatrix * (C + vec4(R, 0, R, 0));
		EmitVertex();
		
		EndPrimitive();
	}
}
