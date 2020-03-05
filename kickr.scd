
/*Here's the synth*/
(
a = SynthDef(\kickr, { arg freq = 500, pitch_d = 0.05, decay = 2, noise_d = 0.02, noise_amp = 0.05;
    var main_osc, noise_osc, pitch_mod1, pitch_mod2, amp_mod, noise_mod, total;

    //Envelopes
    pitch_mod1 = EnvGen.kr(
        Env.perc(attackTime: 0, releaseTime: pitch_d),
    );


    amp_mod = EnvGen.kr(
        Env.perc(attackTime: 0, releaseTime: decay),
        doneAction: 2
        // This is the one in charge of turning off the volume, so this is the one with doneAction: 2
    );

    noise_mod = EnvGen.kr(
        Env.perc(attackTime: 0, releaseTime: noise_d),
    );



    //Oscillators
    main_osc = SinOsc.ar(freq: freq * pitch_mod1, mul: 0.5 * amp_mod);
    noise_osc = PinkNoise.ar(mul: noise_mod * noise_amp);

    //Output
    // total = main_osc + noise_osc;
    // total = Mix.new([main_osc, noise_osc]);
    total = main_osc + noise_osc;
    Out.ar([0,1], total)
}
).add
)

a = Synth(\kickr, [freq: 500, pitch_d: 3, decay: 5, noise_d: 4, noise_amp: 0.8])

/*A little test*/
//Acid dancehall
(
var tempoclock = TempoClock(100/60);
{
    var nu_freq, nu_decay;
    inf.do{
        2.do{
            Synth(\kickr, [freq: 300, decay: 4, pitch_d: 0.1]);
            0.25.wait;
            nu_freq = rrand(5000, 10000);
            2.do{
                nu_decay = rrand(0.001, 0.5);
                Synth(\kickr, [freq: nu_freq, decay: nu_decay]);
                0.25.wait;
            };
        };
        Synth(\kickr, [freq: 900]);
        0.25.wait;
        nu_decay = rrand(0.001, 0.5);
        Synth(\kickr, [freq: nu_freq, decay: nu_decay]);
        0.25.wait;
    }
}.fork(tempoclock)
)


/*More sequences*/

/*GUI Code*/

(

var w, slid2d, c_freq, c_pitch;


w=Window("My Window", Rect(100,300,400,200));

slid2d= Slider2D(w,Rect(5,5,175,175));

b = Button(w, Rect(200, 4, 170, 170))
.states_([["Kick it", Color.black]])
        .action_({ arg butt;
            butt.value.postln;
    // Synth(\kickr, [\freq,100+(10000*slid2d.y),\pitch_d, 0.01+(0.09*slid2d.x)]);  //I'm doing my own linear mapping here rather than use a ControlSpec
        });

slid2d.action_({

	[slid2d.x, slid2d.y].postln;
    Synth(\kickr, [\freq,100+(10000*slid2d.y),\pitch_d, 0.01+(0.09*slid2d.x)]);


});


w.front;


//w.onClose={;};	//action which stops running synth when the window close button is pressed

)


