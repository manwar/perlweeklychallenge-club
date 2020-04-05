#!/usr/bin/env raku
use MONKEY-TYPING;
augment class Int {
	method factorial() {
		self==0??1!! [*] (1..self);
	}
}

my ($n,$k)=(Int(@*ARGS[0]//3), Int(@*ARGS[1]//4));
die "n and k must be >= 1)" if $n < 1 or $k < 1;
my $pCount= $n.factorial/($n-$k).factorial;
die "k must be lest than n! =  $pCount" if $k>$pCount;

#actually select the kth permutation
say (1..$n).permutations[$k-1].join;


