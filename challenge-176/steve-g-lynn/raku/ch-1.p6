#!/usr/bin/env raku 

for (1 .. 200_000) -> $i {
	my $i_gist = $i.comb.sort.gist;
	(($i*2).comb.sort.gist eq $i_gist) || (next);
	(($i*3).comb.sort.gist eq $i_gist) || (next);
	(($i*4).comb.sort.gist eq $i_gist) || (next);
	(($i*5).comb.sort.gist eq $i_gist) || (next);
	(($i*6).comb.sort.gist eq $i_gist) || (next);
	(say $i) && last;
}

#142857

