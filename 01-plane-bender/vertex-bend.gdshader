shader_type spatial;

uniform float bend_rise = 1.3;
uniform vec2 bend_pivot = vec2(0,0);
uniform vec2 bend_axis = vec2(1,0); // ax + by 
uniform float bend_radius = 0.5;

float dist_from_bend(vec2 pt) {
	vec2 relpt=(pt - bend_pivot);
	float dist=abs(pt.x*bend_axis.x+pt.y*bend_axis.y)/length(bend_axis);
	return dist;
}

void vertex() {
	float height = dist_from_bend(VERTEX.xz) * bend_rise;
	VERTEX.y = height;
	 //= sin(VERTEX.x*6.5) * height_scale;
}

void fragment() {
	ALBEDO.xyz = vec3(VERTEX.y*0.2+0.3);
}