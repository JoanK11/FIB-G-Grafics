#version 330 core
out vec4 fragColor;

uniform sampler2D colorMap;

uniform float SIZE;

uniform int display;

void main()
{
    vec2 st = (gl_FragCoord.xy - vec2(0.5)) / SIZE;
    
    vec4 c = texture2D(colorMap, st*2);
    if(display == 0)
	fragColor = vec4(c.r, 0, 0, 1);
    else if(display == 1)
	fragColor = vec4(0, c.g, 0, 1);
    else if(display == 2)
	fragColor = vec4(0, 0, c.b, 1);
    else
	fragColor = vec4(c.a, c.a, c.a, 1);
    
}

