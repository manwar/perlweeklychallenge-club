#!/usr/bin/perl

#time (bash) output:
#real	0m0.026s
#user	0m0.019s
#sys	0m0.007s

# but this fast time degrades sharply with larger problems
#
# real is 0m45.199s if home_prime(48) also printed
# real is 5m5.662s if home_prime of 48 and 65 also printed
# real is 8m50.059s if home_prime of 48, 65 and 96 also printed
#
# probably some slowdown in factor(.) for factors of very large primes 

use Math::Prime::Util qw(is_prime factor);

print &home_prime(10),"\n";
#773

print &home_prime(16),"\n";
#31636373

print &home_prime(20),"\n";
#3318308475676071413

sub home_prime {
	my ($n)=@_;
	is_prime($n) && return $n;
	return	&home_prime(join('',sort{$a<=>$b}(factor($n))));
}


1;

