~density = 25;
~pan = 0;
~rls = 1;

~makeRaspVoice = {
	|uid, voicer, chan, out|

	voicer.makeNote = { |q, chan, note, vel|
		if(rand(~density/100).coin, {
			voicer.rasp.put(note, [
				\freq, (note.linlin(0,127,36,72).round).keyToDegree(~scale,12).degreeToKey(~scale).midicps,
				\vel, (vel/127),
				]);
		});
	};

	voicer.endNote = { |q, chan, note|
		var obj = voicer.rasp.proxy.objects[note];
		if (obj.notNil) { obj.set(\gate, 0) };
	};

	voicer.setMod1 = { |q, chan=0, mod = 0|
		~mod1 = mod/127;
		voicer.rasp.proxy.objects.do({|item|
			if (item.notNil) { item.set(\mod1, (mod/127)) };
		})
	};

	MIDIdef.noteOn(\raspOn ++ out, { |vel, noteNum, chan|
		// "noteOn: % % %\n".postf(noteNum, vel, chan);
		voicer.makeNote(chan, noteNum, vel);
	},srcID:uid, chan: chan).enable;

	MIDIdef.noteOff(\raspOff ++ out, { |vel, noteNum, chan|
		// "noteOff: % % %\n".postf(noteNum, vel, chan);
		voicer.endNote(chan, noteNum);
	},srcID:uid, chan: chan).enable;

	MIDIdef.cc(\raspMod1 ++ out, { |val, ccnum, chan|
		// ("cc11 " + ccnum  + val + chan).postln;
		voicer.setMod1(chan, val);
	},11,srcID:uid, chan: chan).enable;
	};





"rasp voice created !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!".postln;
