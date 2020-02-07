#!/usr/bin/env perl6

my @doors=False xx 500; #doors initally closed
@doors[$_]=!@doors[$_] for 0..499; #First person opens all
for (2..500) -> $i {
	my @index=($i, {$_+$i} ... * >= 500).grep(* <= 500).map: *-1;
	@doors[$_]=!@doors[$_] for @index;
}
put @doors>>.Num;
	

