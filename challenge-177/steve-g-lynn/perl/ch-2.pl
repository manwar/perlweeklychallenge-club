#!/usr/bin/env perl

#real	0m1.206s
#user	0m0.911s
#sys	0m0.286s

use Math::Prime::Util qw(is_prime);

our @retval=();

&find_cyclops(101 .. 999);
&find_cyclops(10001 .. 99999);
&find_cyclops(1_000_001 .. 9_999_999);

print join (' ', @retval), "\n";

#101 16061 31013 35053 38083 73037 74047 91019 94049 1120211 1150511 
#1160611 1180811 1190911 1250521 1280821 1360631 1390931 
#1490941 1520251

sub find_cyclops {

	for my $i (@_) {
		(is_prime $i) || next;
		(substr($i, length($i)/2,1) eq '0') || next;
		(substr($i, 0, length($i)/2-0.5) =~ /0/) && next;
		(substr($i, length($i)/2+1.5 ) =~ /0/) && next;
		(substr($i, 0, length($i)/2-0.5) eq substr(reverse($i), 0, length($i)/2-0.5)) || next;
		push @retval, $i;
		last if scalar(@retval) > 19;
	}
}

