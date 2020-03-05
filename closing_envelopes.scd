e = Env([1, 0.2, 0.7, 0.4, 0], [0.5, 0.5, 0.5, 1], \step, 3, 1)
d = Env([1, 1.5, 1, 0.5, 1], [0.5, 0.5, 0.5, 0.5], 2, 3, 0)
d.plot
e.plot

(
a = {
    arg amp_gate = 1, freq_gate = 1;
    var freq = 330 * EnvGen.kr(d, freq_gate);
    var freq_st = [freq, freq];
    SinOsc.ar(
        freq_st,
        0,
        EnvGen.kr(e, amp_gate)
    )
}.play
)

a.set(\amp_gate,1)
a.set(\freq_gate, 1)