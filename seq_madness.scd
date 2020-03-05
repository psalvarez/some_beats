(
{Impulse.ar(MouseX.kr(1,100))}.play
)

{Dust.ar(MouseX.kr(1,100))}.play

(

{

	[

	LFNoise0.ar(100),	//step

	LFNoise1.ar(100),	//linear interpolation

	LFNoise2.ar(100)	//quadratic interpolation

	]

}.plot(0.1)

)

{SinOsc.ar(freq:440 * LFNoise0.ar(MouseX.kr(1,19)))}.play

{SinOsc.ar(freq:880 * LFNoise1.ar(MouseY.kr(20,1000)))}.play

{Dust.ar(LFNoise0.ar(1000))}.play