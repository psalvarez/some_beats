(
SynthDef(\metal, { arg tone = 8, rate = 4;
    var signal, gb_freq, gb_depth, gb_amp;

    //Modulations
    gb_freq= Saw.kr(rate / 2, mul: SampleRate.ir / tone, add: SampleRate.ir /  (tone * 2));
    gb_amp = EnvGen.kr(Env.perc(releaseTime: 0.05), gate: Impulse.kr(rate));

    //Main source
    signal = GbmanL.ar(gb_freq, xi: 100, yi: 2, mul: gb_amp * 0.1);
    Out.ar([0, 1], signal);
}).add;
)

a = Synth(\metal)
a.set(\tone, 4)
a.set(\rate, 10)

(
 // GUI Shit
var window, size = 200, k_tone, k_rate;
//Synth
a = Synth(\metal);

window = Window("Tick Tock madaf...", Rect(size, size, size * 2, size));

k_tone = Knob.new(window, Rect(size / 4, size / 4, size / 2, size / 2));
k_rate = Knob.new(window, Rect(size, size / 4, size / 2, size / 2));

k_tone.mode = \vert;
k_rate.mode = \vert;

//GUI action
k_tone.action_({a.set(\tone, k_tone.value * 100); k_tone.value.postln});
k_rate.action_({a.set(\rate, k_rate.value * 100); k_rate.value.postln});


window.front; //make GUI appear

)