// Morse beeping
(
x = {
    // arg gate;
    var sin, env, gate;
    gate = Dust .kr(5);
    env = EnvGen.kr(
        Env.linen(sustainTime: 0.07, releaseTime: 0.1),
        gate: gate,
    );
    sin = SinOsc.ar(700, mul: 0.1) * env;
    Mix.new(sin)!2
}.scope
)

x.set(\gate, 0)
x.free


// Sine texture
(
{
    inf.do {
        y = {
            var sig, env;
            env = EnvGen.kr(
                Env.sine(10, 0.2),
                doneAction: 2
            );
            sig = SinOsc.ar(Array.fill(5, {rrand(200, 500)}), mul:SinOsc.kr(Array.fill(5, {rrand(0.1, 17)}))) * env * 0.2;
            Splay.ar(sig)
        }.play;
        7.wait;
    };
}.fork
)

y.free


// Noise
(
z = {
    var noise, env;
    env  = EnvGen.kr(
        Env.linen(attackTime: 0, sustainTime: 0.2, releaseTime: 0.1),
        gate: Dust .kr(0.3);
    );
    noise = PinkNoise.ar(mul: 0.3) * env;
    noise = BPF.ar(noise, 1000);
    Mix.new(noise)!2
}.scope
)

z.free
Env.linen(sustainTime: 0.2, releaseTime: 0.1).plot