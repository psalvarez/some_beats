(
 // GUI Shit
var window, size = 200;
//Synth
a = Synth(\donald);

window = Window("Yeah", Rect(size, size, size, size));
k = Knob.new(window, Rect(size / 4, size / 4, size / 2, size / 2));
k.mode = \vert;

//GUI action
k.action_({a.set(\speed, k.value * 100); k.value.postln});


window.front; //make GUI appear

)


