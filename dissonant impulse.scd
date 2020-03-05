(
x = {
    arg gate = 0;
    var src, amp, env;
    env = EnvGen.kr(
        envelope: Env.new([1, 0.0001], [2], curve: ['exp']),
        gate: 1,
        doneAction: 2
    );
    amp = SinOsc.kr({ExpRand.new(3, 10)}!10);
    src = SinOsc.ar({ExpRand.new(200, 800)}!10);
    src = src * amp * env;
    src = Splay.ar(src);
}.play
)


x.free