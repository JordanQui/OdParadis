SynthDef(\silence, {
	|
	out=0
	|
	var sig = WhiteNoise(0);
	Out.ar(0,sig);
	}).store;


SynthDef(\oudini_00, {
	|
	out, gate=1, freq
	|
	var sig, env, burst;
	env = Env.adsr(0,1,1,0.7).ar(2,gate);
	burst = WhiteNoise.ar(1) * Env.perc(0,0.01).ar(0,gate);
	sig = MiElements.ar(0, burst, pit: freq.cpsmidi, geom: 0, bright:0.11, damp:0.9, model:1);
	sig = sig * env * 0.25;

	sig = HPF.ar(sig, 400);

	Out.ar(out, sig!2);
	}).store;


SynthDef(\oudini_01, {
	|
	out, gate=1, freq
	|
	var sig, env, burst;
	env = Env.adsr(0,1,1,5).ar(2,gate);
	burst = WhiteNoise.ar(1) * Env.perc(0,0.01).ar(0,gate);
	sig = MiElements.ar(0, burst, pit: freq.cpsmidi, geom: 0, bright:0.11, damp:0.9, model:1);
	sig = sig * env * 0.7;

	sig = GVerb.ar(sig,
		roomsize: 400,
		revtime: 3,
		damping: 0.5,
		inputbw: 0.5,
		spread: 15,
		drylevel: 0,
		earlyreflevel: 0.7,
		taillevel: 0.5,
		maxroomsize: 400
	);

	Out.ar(out, sig);
	}).store;


SynthDef(\oudini_02, {
	|
	out, gate=1, freq
	|
	var sig, env, burst;
	env = Env.adsr(0,1,1,5).ar(2,gate);
	burst = WhiteNoise.ar(1) * Env.perc(0,0.01).ar(0,gate);
	sig = MiElements.ar(0, burst, pit: freq.cpsmidi, geom: 0, bright:0.11, damp:0.9, model:1);
	sig = sig * env * 0.6;

	sig = GVerb.ar(sig,
		roomsize: 400,
		revtime: 3,
		damping: 0.5,
		inputbw: 0.5,
		spread: 15,
		drylevel: 0,
		earlyreflevel: 0.7,
		taillevel: 0.5,
		maxroomsize: 400
	);

	sig = sig * SinOsc.ar([freq*4,freq*8,freq*12,freq*14]);
	sig = Mix.new(sig);

	Out.ar(out, sig);
	}).store;



SynthDef(\synthoud, {|
	out=0, gate=1, freq, vel, amp, mod, bend, rls=1
	|

	var in1, in2, burst, sig, sig2, body, ampcomp, env,
	freq2 = freq * bend.midiratio,
	pitch = freq2.reciprocal - ControlRate.ir.reciprocal;

	ampcomp = AmpComp.kr(freq2);
	in1 = LocalIn.ar(1);
	in2 = LocalIn.ar(1);
	burst = WhiteNoise.ar(vel.linlin(0,1,0.01,0.5)) * Env.perc(0,0.1).kr(0,gate);
	env = Env.adsr(0,1,1,1).ar(2,gate);

	sig = DelayC.ar(burst + (in1 * 0.991), 1, pitch);
	sig2 = DelayC.ar(burst + (in2 * 0.991), 1, pitch+0.005);
	// body = SinOsc.ar(freq2.lag(0.2)) * Env.adsr(0.5,0,1,rls).kr(0,gate) *0.1;

	// DetectSilence.ar(sig, doneAction: Done.freeSelf);
	LocalOut.ar(sig);
	LocalOut.ar(sig2);

	sig = RLPF.ar(sig, 300 + Env.perc(0,0.1).kr(0,gate).range(0,2000) ) * 1;

	Out.ar(out, sig*ampcomp!2);
	},
	metadata: (
		credit: "print.helen",
		category: [\karplus, \percussive]
	)).store;
