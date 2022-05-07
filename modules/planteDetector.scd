{
	var ip = Pipe.new("hostname -I | awk '{print $1}'" , "r").getLine;

	if(ip !== nil) {
		var x = case
			{ ip.contains("201") } { ~plt = 1 }
			{ ip.contains("202") } { ~plt = 2 }
			{ ip.contains("203") } { ~plt = 3 }
			{ ip.contains("204") } { ~plt = 4 }
			{ ip.contains("205") } { ~plt = 5 }
			{ ip.contains("206") } { ~plt = 6 };
			ip.postln;
	};
	( "============== WE ARE ON PLANT " ++ ~plt ).postln;
}.value;
