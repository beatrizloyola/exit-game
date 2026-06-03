shader_type spatial;
render_mode unshaded;

uniform float noise_scale : hint_range(1.0, 500.0) = 200.0;
uniform float scanline_count : hint_range(1.0, 500.0) = 180.0;
uniform float flicker_speed : hint_range(0.0, 100.0) = 24.0;
uniform float glitch_intensity : hint_range(0.0, 1.0) = 0.6;

float random(vec2 uv) {
	return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453123);
}

void fragment() {
	vec2 uv = UV;

	// Time-based flicker seed
	float t = floor(TIME * flicker_speed);

	// Coarse noise
	vec2 coarse = floor(uv * vec2(noise_scale * 0.4, noise_scale * 0.3));
	float grain = random(coarse + vec2(t, t * 1.7));

	// Fine noise
	vec2 fine = floor(uv * vec2(noise_scale, noise_scale * 0.75));
	float detail = random(fine + vec2(t * 0.9, t * 2.3)) * 0.25;

	float noise = grain * 0.75 + detail;

	// Scanlines
	float scanline = 0.8 + 0.2 * sin(uv.y * PI * scanline_count);
	noise *= scanline;

	// Random glitch bars
	float bar_row = floor(uv.y * 40.0 + TIME * 2.5);
	float glitch = step(0.93, random(vec2(bar_row, t * 0.3)));
	noise += glitch * random(vec2(uv.x * 80.0, bar_row)) * glitch_intensity;

	// Vertical roll (loss of sync)
	float roll = fract(uv.y + TIME * 0.07);
	float roll_band = smoothstep(0.0, 0.04, roll) * smoothstep(1.0, 0.96, roll);
	noise *= mix(0.3, 1.0, roll_band);

	// Vignette
	vec2 v = uv * 2.0 - 1.0;
	float vignette = 1.0 - dot(v, v) * 0.35;

	noise = clamp(noise * vignette, 0.0, 1.0);

	ALBEDO = vec3(noise);
}
