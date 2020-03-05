(
Ndef(\pulses, {var pulsion, freq;
    freq = 4 * (1 + LFPulse.kr(0.5));
    pulsion = Impulse.ar(freq, mul: 2);
    pulsion = BPF.ar(pulsion, freq: 1200 * (1 + LFNoise1.kr(40, mul: 0.5)), rq: 0.3);
    Pan2.ar(pulsion, pos: SinOsc.kr(0.2, mul: 0.5))
}).play
)

(
Ndef(\pad, {var src;
    src = Saw.ar([50, 53, 57, 60].midicps, mul: 0.2);
    src = BPF.ar(src, freq: [300, 1400, 1200, 300] * (1 + SinOsc.kr(0.1, mul:0.1)), mul: LFNoise0.kr(freq: 4));
    Splay.ar(src)
}).play
)

Ndef.clear
Server.freeAll


