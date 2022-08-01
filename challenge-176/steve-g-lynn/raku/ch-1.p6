#!/usr/bin/env raku 

for (1 .. 200_000) -> $i {
	(($i*2).comb.sort eqv ($i*3).comb.sort) || (next);
	(($i*3).comb.sort eqv ($i*4).comb.sort) || (next);
	(($i*4).comb.sort eqv ($i*5).comb.sort) || (next);
	(($i*5).comb.sort eqv ($i*6).comb.sort) || (next);
	(say $i) && last;
}

#142857

