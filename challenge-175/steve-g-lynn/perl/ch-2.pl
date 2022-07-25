#!/usr/bin/env perl

use Math::Prime::Util qw(euler_phi);

my $ctr=0;
for my $i (2 .. 10_000) {
	if ($i == &iterated_totient($i)){
		print "$i ";
		$ctr++;
	}
	last if $ctr >= 20;	
}
print "\n";


# referred to perl 5 code in https://oeis.org/A082897
sub iterated_totient {
	my ($n)=@_;

	my $totient=euler_phi($n);

	return 1 if $totient == 1;

	return $totient + iterated_totient($totient); 
}
