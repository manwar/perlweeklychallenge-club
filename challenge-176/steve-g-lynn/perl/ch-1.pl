#!/usr/bin/env perl 

for $i (1 .. 200_000)  {
	(&comb_sort($i*2) == &comb_sort($i*3)) || (next);
	(&comb_sort($i*3) == &comb_sort($i*4)) || (next);
	(&comb_sort($i*4) == &comb_sort($i*5)) || (next);
	(&comb_sort($i*5) == &comb_sort($i*6)) || (next);
	((print "$i\n") && (last));
}

sub comb_sort { 
	my ($n) = @_;
	return join '',sort {$a <=> $b} (split //, $n);
}
