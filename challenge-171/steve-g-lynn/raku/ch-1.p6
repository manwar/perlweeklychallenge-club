#!/usr/bin/raku

#Slow! time (bash):
#real	0m2.593s
#user	0m2.667s
#sys	0m0.107s

use Prime::Factor;

my @retval=();
loop (my $n=1;;$n+=2) {
#loop over odd numbers
	( (sum divisors $n) > (2*$n) ) && (push @retval, $n);
	# divisors includes n, so compare sum divisors with 2n
	@retval.elems > 19 && last; 
}

say @retval;

