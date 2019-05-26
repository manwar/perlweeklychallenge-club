#!/usr/bin/env perl6
my @inputs= [1,2,2,6];
say do for @inputs {
	state $prev=$_;
	state  $r=1;
	NEXT { $prev=$_};	
	$r= ($prev !== $_) ?? $r+1 !! $r;
	say $r;
	$r+0; # THIS IS REQUIRED for some reason
};

sub bug (@vals) {
	@vals.map: {
		state $prev=$_;
		state  $r=1;
		NEXT { $prev=$_};	
		$r= ($prev !== $_) ?? $r+1 !! $r;
		say $r;
		$r;
	};
}

say bug(@inputs);
