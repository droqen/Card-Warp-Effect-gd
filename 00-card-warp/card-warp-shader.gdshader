shader_type spatial;

float cardwarpat(vec2 pt) {
	return 0.3 * cos(pt.x*1.31) * sin(pt.y*1.11);
}

void vertex() {
	VERTEX.y += 0.5 * cos(VERTEX.x*3.31) * sin(VERTEX.z*4.11);
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
