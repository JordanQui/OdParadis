~ipPlant1 = NetAddr("192.168.11.201", 57120);
~ipPlant2 = NetAddr("192.168.11.202", 57120);
~ipPlant3 = NetAddr("192.168.11.203", 57120);
~ipPlant4 = NetAddr("192.168.11.204", 57120);
~ipPlant5 = NetAddr("192.168.11.205", 57120);
~ipPlant6 = NetAddr("192.168.11.206", 57120);
~ipBundle = [
	~ipPlant2,
	~ipPlant3,
	~ipPlant4,
	~ipPlant5,
	~ipPlant6
];

~ipVideo1 = NetAddr("192.168.11.101", 5005);
~ipVideo2 = NetAddr("192.168.11.102", 5005);
~ipVideo3 = NetAddr("192.168.11.103", 5005);
~ipVideo4 = NetAddr("192.168.11.104", 5005);
~ipVideo5 = NetAddr("192.168.11.105", 5005);
~ipVideo6 = NetAddr("192.168.11.106", 5005);
~ipVideoBundle = [
	~ipVideo1,
	~ipVideo2,
	~ipVideo3,
	~ipVideo4,
	~ipVideo5,
	~ipVideo6,
];









OSCdef(\start_install, {|x|
	~conductor.play(doReset:true);
	if(~plt === 1, {
		~ipBundle.do({|item| item.sendBundle(nil, ['/start_install', 1]) });
		~ipVideoBundle.do({|item| item.sendBundle(nil, ['/play', 1]) });
		"start video".postln;
	});
	"start install".postln;
},'/start_install');

OSCdef(\restart_install, {|x|
	// ~conductor.stop;
	if(~plt === 1, {
		// ~ipBundle.do({|item| item.sendBundle(nil, ['/restart_install', 1]) });
		~ipVideoBundle.do({|item| item.sendBundle(nil, ['/reset', 1]) });
	});
	// ~conductor.play(doReset: true);
	"restart install".postln;
},'/restart_install');


OSCdef(\setVolumeALL, {|x|
	("-------- volume" + x[1].value).postln;
	s.volume = x[1].value.squared.ampdb;
	if(~plt === 1, {
		~ipBundle.do({|item| item.sendBundle(nil, ['/setVolumeALL', x[1].value]) });
		~ipVideoBundle.do({|item| item.sendBundle(nil, ['/volume', (x[1].value * 100) ]) });
	});
	"volume".postln;
},'/setVolumeALL');
