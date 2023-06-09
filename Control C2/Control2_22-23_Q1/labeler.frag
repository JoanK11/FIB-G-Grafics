#version 330 core

in vec4 gfrontColor;
out vec4 fragColor;

in vec2 st;

const vec4 yellow = vec4(1, 1, 0, 1); 

bool inside() {
	if ((st.s >= 2 && st.s < 3 && st.t >= 1 && st.t < 6) || // Pal esquerre
	(st.s >= 3 && st.s < 5 && st.t >= 5 && st.t < 6) || // Part superior
	(st.s >= 3 && st.s < 4 && st.t >= 3 && st.t < 4)) return true; // Part del centre
	return false;
}

void main() {
	// Pintem normal
	if (st.s < 0) {
		fragColor = gfrontColor;
	}
	// Pintem la F
	else {
		if (inside()) fragColor = vec4(0);
		else fragColor = yellow;
	}
}
