#!/usr/bin/env raku

A: for (1 .. 100) -> $n {
	my @digits = ($n+flip($n)).comb;

	for (@digits) -> $digit {
		($digit %% 2) && (next A); 	
	}
	say "$n ";
}

