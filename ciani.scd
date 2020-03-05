// THIS IS THE WAY TO GO FOR LIVE SHIT. LONG LIVE Ndefs !!!!!

//Main noise and bleeps synth
(
Ndef(\ciani, {arg noise_freq = 0.1, bleep_freq = 10;
    var noise_move, noise_source, total_source, bleep, noise, noise_pan;

    //Noise settings
    //noise_freq = MouseX.kr(0, noise_freq);
    noise_move = SinOsc.kr(freq: 1* noise_freq);
    noise_source = WhiteNoise.ar(mul: 1);
    noise_pan = Pan2.ar(noise_source, pos: noise_move);
    noise = BPF.ar(noise_pan, freq: 800 + noise_move, rq: 0.1, mul: 1);

    //Bleep settings
    //bleep_freq = MouseY.kr(2, bleep_freq);
    bleep = SinOsc.ar(freq: 440 * (LFDNoise0.kr(freq: 1 * bleep_freq)), mul: 0.5);

    /*Add both and output. Apparently, having this last variable here, is FUCKIN IMPORTANT for the Ndef. It looks like it only looks at the
    last operation with UGens*/
    total_source = noise + bleep;

    // Out makes Ndef to not fade well and shit. It behaves weird. Avoid it.
    //Out.ar([0,1], total_source);
}).fadeTime_(5).play
)


(
Ndef(\pings, { var amp_env, pulse_src, base_freq = 700;
    amp_env = EnvGen.kr(Env.perc(level: 0.5, releaseTime: 0.1 + Ndef.kr(\rel)), Impulse.kr(freq: 6));
    pulse_src = Pulse.ar(base_freq * (1 + Ndef.kr(\freq))!2, mul: amp_env);
    LPF.ar(pulse_src, freq: 1500)
}).play
)

Ndef(\rel, {Pulse.kr(freq: 4, width: LFNoise0.kr(300), mul: 0.1)}).play

Ndef(\freq, {LFNoise0.kr(15)}).play

Ndef(\pings).stop(fadeTime: 10)
Ndef.clear

Ndef(\ciani).fadeTime = 1
Ndef(\ciani, {SinOsc.ar(400!2)}).fadeTime_(0)
Ndef(\ciani).set(\noise_freq, 0.05)
Ndef(\ciani).set(\bleep_freq, 10)


// This was me thinking Supercollider didn't have an actual way to do live coding
// E D I T: Ndef might be the actual way to do this. Yay! :D
(
n.free;
//Noise synth
n = {arg noise_freq = 0.2;
    var noise_move, noise_source, total_source, bleep, noise;

    //Noise settings
    //noise_freq = MouseX.kr(0.2, noise_freq);
    noise_move = SinOsc.kr(freq: noise_freq);
    //noise_source = WhiteNoise.ar(mul: noise_move * -1);
    noise_source = WhiteNoise.ar(mul: 0.2);
    noise = Pan2.ar(noise_source, pos: noise_move);


}.play;

)

// Bleep Synth
(
b.free;
b = {arg bleep_freq = 5;
    //Bleep settings
    //bleep_freq = MouseY.kr(2, bleep_freq);
    var bleep;
    bleep = SinOsc.ar(freq: 440 * (LFDNoise0.kr(freq: 1 * bleep_freq)));

    Out.ar([0, 1], bleep);
}.play
)

(
s.free;
s = {
    var bass;
    bass = Saw.ar(freq: 55, mul: (SinOsc.kr(freq: 0.1)));
    Out.ar([0, 1], bass);
}.play
)

Ndef


// Control Live shit
n.set(\noise_freq, 0.2)