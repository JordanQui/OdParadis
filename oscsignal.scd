// init osc singers
~ipPlant1 = NetAddr("192.168.11.201", 57120);
~ipPlant2 = NetAddr("192.168.11.202", 57120);
~ipPlant3 = NetAddr("192.168.11.203", 57120);
~ipPlant4 = NetAddr("192.168.11.204", 57120);
~ipPlant5 = NetAddr("192.168.11.205", 57120);
~ipPlant6 = NetAddr("192.168.11.206", 57120);
~ipBundle = [
	~ipPlant1,
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

~ipBundle.do({|item| item.sendBundle(nil, ['/start_install', 1]) });
~ipVideoBundle.do({|item| item.sendBundle(nil, ['/reset', 1]) });

~ipVideoBundle.do({|item| item.sendBundle(nil, ['/play', 1]) });
~ipVideoBundle.do({|item| item.sendBundle(nil, ['/volume', 0]) });




~ipBundle.do({|item| item.sendBundle(nil, ['/restart_install', 1]) });
