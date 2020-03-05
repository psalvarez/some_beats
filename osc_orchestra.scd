(
a = {
	var freq, freq_mod, amp_mod, osc_freq;
	freq = 200;
	freq_mod = LFPulse.kr(freq: 0.25, iphase: 0.0, width: 0.01, mul: 1.0, add: 1.0);
	amp_mod = Saw.kr(freq: 1);
	osc_freq = [freq * freq_mod, freq * freq_mod];
	SinOsc.ar(freq: osc_freq, mul: amp_mod)
}.scope;
)

a.run()
a.run(false);
(
b  = {
	var freq, freq_mod, amp_mod, freq_st;
	freq = 75;
	freq_st = [freq + 1, freq - 1];
	amp_mod = LFTri.kr(freq: 0.02, mul: 0.2);
	Saw.ar(freq_st, amp_mod)
}.scope
)
b.run(false)
(
c = {
	var freq, freq_mod, amp_mod, freq_st, src;
	freq = 6000;
	freq_st = [freq + 1, freq - 1];
	freq_mod = LFTri.kr(freq: 14, mul: 1, add: 50);
	amp_mod = LFPulse.kr(freq: 5, width: 0.1, mul: 0.2);
	src = {WhiteNoise.ar([amp_mod, amp_mod])};
	BBandPass.ar(src, freq: freq + freq_mod);
}.scope
)
c.run(false)



