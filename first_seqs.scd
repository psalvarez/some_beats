(

SynthDef(\event,{ arg freq=440, amp=0.5, pan=0.0;

	var env;



	env = EnvGen.ar(  Env([0,1,1,0],[0.01, 0.1, 0.2]),  doneAction:2);



	Out.ar(0,  Pan2.ar(Blip.ar(freq) * env * amp, pan))

}).add;

)

Synth(\event)	//accepts defaults. Event shouldn't hang around once envelope finished due to doneAction:2

Synth(\event,[\freq,880,\amp,0.2,\pan,1]) //pan 1.0 should send to right ear


(

{



	Synth(\event);



	1.0.wait;	//wait for 1 time unit of default tempo, will probably work out to 1 second



	Synth(\event);



}.fork; 	//.fork is a computer science term for setting a new process (sequence) in action

)

(

{


    inf.do {
        8.do {

            Synth(\event,[\freq, rrand(200,220)]);

            rrand(0.2,0.6).wait;

        };



        4.do {

            Synth(\event);

            0.25.wait;

        };
    }



}.fork;

)

TempoClock.default.tempo = 3 //get tempo in beats per second.


{Impulse.ar(MouseX.kr(1,100))}.play

{ Stepper.ar(Impulse.ar(100), 0,1,10,1) }.plot(0.3,minval:0,maxval:10);

(
{ Saw.ar(
    Select.kr(
        Stepper.kr(
            Impulse.kr(4,0.1),0,0,7,1
        ),
        [72,63,67,72,55,62,63,60].midicps
    ),
    0.1
)
}.play
)

(
SynthDef(\singrain, { |freq = 440, amp = 0.2, sustain = 1|
    var sig;
    sig = SinOsc.ar(freq, 0, amp) * EnvGen.kr(Env.perc(0.01, sustain), doneAction: Done.freeSelf);
    Out.ar(0, sig ! 2);    // sig ! 2 is the same as [sig, sig]
}).add;

a = {
    arg delta;
    {
        delta = 0.5;
        Synth(\SOSkick);
        delta.yield;
    }.loop
};

r = Routine(a);
r.play
)

