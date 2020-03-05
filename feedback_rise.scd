
(
{
	var freq, base_freq;
	base_freq = Line.kr(0, 20, 60);
	freq = Pulse.kr(base_freq, mul:3);
	SinOscFB.ar([base_freq*10, base_freq*10] + freq, freq);
	// Saw.ar([200, 400, 100], base_freq * 0.2)
}.scope
)

// 