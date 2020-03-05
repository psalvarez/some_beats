(
SynthDef(\zing, { arg dur = 1, c_freq = 880;
    var modulator, carrier, c_amp, m_amp;

    c_amp = EnvGen.kr(Env.perc(releaseTime: dur), doneAction: 2);
    m_amp = EnvGen.kr(Env(levels: [1, 0], times: [dur / 2]), doneAction: 2);

    modulator =  SinOsc.kr(100, mul: 3 * m_amp);
    carrier = Pulse.ar(c_freq * modulator, mul: 0.4 * c_amp);
    Out.ar([0, 1], carrier)
}
).add
)

a = Synth(\zing, [dur: 1])

(
var tempoclock = TempoClock(3);  //3 beats per second
p = {
    a = 1;
    f = 1000;
    inf.do {
        c = rrand(2, 7);
        Synth(\zing, [dur: a,  c_freq: f / c]);
        (a / 2).wait;
        f = rrand(500, 8000);
        Synth(\zing, [dur: a / 4, c_freq: f]);
        rrand(0.25, 0.8).wait;
    };
    Synth(\zing, [dur: a]);
}.fork(tempoclock)
)

(
var tempoclock = TempoClock(126/60);  //3 beats per second
p = {
    inf.do {
        a = 1;
        f = rrand(800, 1000);
        3.do {
            c = rrand(2, 7);
            Synth(\zing, [dur: a,  c_freq: f / c]);
            1.wait;
        };

        16.do {
            // f = rrand(500, 8000);
            Synth(\zing, [dur: a / 4, c_freq: f]);
            0.25.wait;
            f = f + rrand(1, 400);
        }
    }
}.fork(tempoclock)
)

p.stop