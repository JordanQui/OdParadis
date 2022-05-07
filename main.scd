/* *
*	GLOBAL ENV VARIABLES
*/
// s.boot; s.makeWindow;
s.latency = 0.1;
o = Server.default.options;
o.memSize = 8192*16;
o.blockSize = 64;
o.hardwareBufferSize = 128;


~environementPath = PathName.new(thisProcess.nowExecutingPath).pathOnly;
~l = ();
~l.add(\smpl -> PathName(~environementPath++"samples").entries.collect({|sf| Buffer.read(s,sf.fullPath);}));


// globale variables
~scale = Scale.chromatic;
~scale.tuning_(\et12);



~oudini = Routine {
	MIDIIn.connectAll;
	"midi connected".postln;
	s.sync;

	PathName(~environementPath++"modules/synths.scd").fullPath.load;
	"synth created".postln;
	s.sync;

	PathName(~environementPath++"modules/planteDetector.scd").fullPath.load;
	"plant detected".postln;
	s.sync;

	PathName(~environementPath++"modules/oscresponders.scd").fullPath.load;
	"remote starter created".postln;
	s.sync;

	PathName(~environementPath++"modules/makevoice.scd").fullPath.load;
	"voice function created".postln;
	s.sync;

	PathName(~environementPath++"conductor.scd").fullPath.load;
	"conductor created".postln;
	s.sync;


	~voicer = ~voicer ? ();
	~voicer.rasp = NPVoicer( Ndef(\rasp) );
	~voicer.rasp.prime(\silence);
	s.sync;
	~voicer.rasp.play;
	s.sync;
	~makeRaspVoice.value(nil, ~voicer, 0, 0);
	"raspberry voices created".postln;
	s.sync;

	// ~voicer.rasp.proxy.filter(150, {|in|
	// 	HPF.ar(in, 400);
	// });


	~l[\smpl].postln;
	("LISTENING ON PORT : " + thisProcess.openPorts).postln;
	Pdef(\x, Pbind(\dur, 0.125, \strum, 0.112, \scale, Scale.minor, \degree, Pseq([[1,2,3], [4,5,6], [7,8,9], [10,11,12]], 1))).play;

	s.volume = 0.2.squared.ampdb;
};


s.waitForBoot({ ~oudini.play(AppClock) });


Quarks.gui
