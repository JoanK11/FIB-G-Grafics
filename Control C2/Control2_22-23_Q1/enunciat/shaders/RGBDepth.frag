#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in float depth;

void main()
{
    fragColor = vec4(frontColor.xyz, 1-depth);
}
