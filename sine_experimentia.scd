(
a  = {
	var freq, freq_mod, amp_mod;
	freq = [200, 200];
	freq_mod = LFPulse.kr(freq: 0.2, mul:2 * freq/5, iphase: 0.5) + LFPulse.kr(freq: 0.1, mul:freq * 2, width: 0.01, iphase:0.9);
	amp_mod = SinOsc.kr(freq: 0.1) + (LFPulse.kr(freq: 0.5, mul:1, width: 0.2, iphase:0.9) * LFTri.kr(mul:1, freq: freq/2));
	SinOscFB.ar(freq: freq + freq_mod, mul:amp_mod, feedback: amp_mod/4 + LFTri.kr(mul:1, freq: freq/100000))
}.scope;
)

(
a  = {
	var freq_st, freq, freq_mod, amp_mod;
	freq = 200;
	freq_st = [freq, freq];
	freq_mod = LFPulse.kr(freq: 1, mul:2 * freq/5, width: 0.25, iphase: 0.25) + LFPulse.kr(freq: 1, mul:freq * 2, width: 0.25, iphase:0.75) + LFPulse.kr(freq: 1, mul:2 * freq/3, width: 0.25, iphase: 0.5) + LFPulse.kr(freq: 0.125, mul: freq, width: 0.125, iphase: 0.60) + LFPulse.kr(freq: 0.02, mul: freq/3, width: 0.125, iphase: 0.450);
	// amp_mod = SinOsc.kr(freq: 0.1) + (LFPulse.kr(freq: 0.5, mul:1, width: 0.2, iphase:0.9) * LFTri.kr(mul:1, freq: freq/2));
	// amp_mod = SinOsc.kr(freq:1);
	amp_mod = 0.5;
	SinOsc.ar(freq: freq_st + freq_mod, mul:amp_mod)
};
a.play
)
