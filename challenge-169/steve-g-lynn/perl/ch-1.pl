#!/usr/bin/perl

#-- generate 1st 20 brilliant numbers
#-- product of two prime factors of same length

use Math::Prime::Util qw(primes);

my @brilliants = ();

for $i (1,2) { # get 1 or 2 digit primes with each iteration
	my $ra=primes(10**($i-1), 10**($i)); 
		
	for $i (0 .. @$ra-1) {
		for $j ($i .. @$ra-1) {
			push (@brilliants, 
			$$ra[$i] * $$ra[$j] );
		}
	} 
}
	
@brilliants = sort{$a <=> $b} @brilliants;

foreach (0 .. 19) {
	print $brilliants[$_]," ";
}

print "\n";




