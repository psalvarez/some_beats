Ndef(\first).play(fadeTime: 5); //start playing 5sec fadein
Ndef(\first).fadeTime= 3; //set crossfade time
Ndef(\first, {LFSaw.ar(400, 0, 0.2)});
Ndef(\first, {WhiteNoise.ar(0.15)}).fadeTime_(5);
Ndef(\first).stop(fadeTime: 5); //stop playing 5sec fadeout

//  The fadeTime for play and stop are not the same as the
//  crossfade time set with fadeTime= ...

Ndef(\second, {SinOsc.ar(500, 0, 0.5)});
Ndef(\second).play;
Ndef(\second).stop;
Ndef(\second, {Pulse.ar(600, 0.5, 0.5)});
Ndef(\second).play;
Ndef(\second).stop;

//Ndefs can be nested in other Ndefs
//notice that we only call .play on Ndef(\third)
Ndef(\third, {LPF.ar(Ndef.ar(\second))});
Ndef(\third).play;
Ndef(\third, {BPF.ar(Ndef.ar(\second), 500, 0.1)});
Ndef(\third).stop;

//more nesting with Ndef
Ndef(\noise, {WhiteNoise.ar(0.5)});
Ndef(\filter, {LPF.ar(Ndef.ar(\noise), 600)});
Ndef(\filter).play;
Ndef(\filter).fadeTime= 5;
Ndef(\filter, {LPF.ar(Ndef.ar(\noise), 300)});
Ndef(\filter).stop;

//simple frequency modulation (FM)
Ndef(\fm, {SinOsc.ar(Ndef.ar(\ctrl)*400, 0, 0.1)});
Ndef(\fm).play;
Ndef(\ctrl, {SinOsc.ar(2)});
Ndef(\ctrl).fadeTime= 5;

// Amplitude Modulation (AM) with replaceable modulator
// and settable fadeTime.

Ndef(\am, {SinOsc.ar(500, 0, Ndef.ar(\ctrl))});
Ndef(\am).play;
Ndef(\ctrl, {SinOsc.ar(5)});
Ndef(\ctrl).fadeTime= 10;
Ndef(\ctrl, {SinOsc.ar(2)});
Ndef(\ctrl, 0);
Ndef(\ctrl, {SoundIn.ar}); //uses mic input as amp control
Ndef(\chaos, {LFNoise0.ar(4)});
Ndef(\ctrl, {Ndef.ar(\chaos)});

//stop
Ndef(\am).stop;