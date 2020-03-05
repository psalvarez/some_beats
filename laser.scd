// Attempt of  a laser Sound

(
SynthDef(\laser,
    {
        arg base_freq = 500;
        var source, pitch_env, filter, freq, amp_env;
        pitch_env = EnvGen.kr(Env.perc(0,  1.0, curve: -5), doneAction:Done.freeSelf);
        //pitch_env = EnvGen.kr(Env([4,0.5,1,1],[0,0.01,1.0]));
        amp_env =  EnvGen.kr(Env.adsr(0, 0.7, 0, 0.6, 1.0, -5), doneAction: Done.freeSelf);
        freq = base_freq * pitch_env;
        //For some reason, the envelope does not free up when affecting pitch
        source = Saw.ar(
            freq: freq,
            mul: 0.8  * amp_env
        );
        filter = BPF.ar(in: source, freq: freq * 2, rq: 0.01, mul: 1.0);
        Out.ar([0, 1], filter)
    }
).add
)

a = Synth(\laser);
a.free
Env([4,0.5,1,1],[0,0.01,1.0]).plot

(
p = Pbind(
    \instrument, \laser,
    \base_freq, Pseq(#[0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 1], 1) * 400,
    \dur, 0.1
).play;
)

Pbind(
    \instrument, \laser,
    \base_freq, Prand([1, 1.2, 2, 2.5, 3, 4], inf) * 200,
    \dur, Pslide([0.1, 0.4, 0.2, 0.5, 0.4],
    inf, len:4, wrapAtEnd:true)
).play;

