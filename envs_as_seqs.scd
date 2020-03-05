(
SynthDef(\seq2,
    {
        arg vib = 0.2, freq = 110, bpm = 120, a_factor = 2, e_factor = 4;
        var freq_st, saw_env, sin_freq, sin_freq_st, beat_t, beat_a, beat_e, finaloutput;
        vib = MouseX.kr(0, 1);
        beat_t = 60 * (1/bpm);
        beat_a = beat_t / a_factor;
        beat_e = beat_t * e_factor;
        a = Env([0.5, 0.5, 0.7, 1.2, 0.7, 1], [beat_a, beat_a, beat_a, beat_a, beat_a], \step, 4, 0);
        e = Env([1, 1, 0.5, 0.5, 1, 1, 1.2, 1.2, 1, 1], [beat_e, beat_e, beat_e, beat_e, beat_e, beat_e, beat_e, beat_e, beat_e], 'lin', 8, 0);
        freq_st = [freq, freq];
        sin_freq = freq * 4 * EnvGen.kr(a);
        sin_freq_st = [sin_freq, sin_freq];
        finaloutput = Saw.ar(freq_st * EnvGen.kr(e), 1, 0) +
        SinOsc.ar(
            sin_freq_st,
            0,
            SinOsc.kr(10, 0.0, vib, 1)
        );
        Out.ar(0, finaloutput)
    }
).add
)

b = Synth(\seq2)

b.set(\vib, 0.6)
b.set(\freq, 65)
b.set(\a_factor, 4)
b.set(\e_factor, 1)
b.free

SynthDescLib.global.browse; // browse the properties of available SynthDescs in the system