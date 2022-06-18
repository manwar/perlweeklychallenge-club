#!/usr/bin/perl

#time (bash) output:
#real	0m0.177s
#user	0m0.170s
#sys	0m0.006s


use bigint;

use Math::Prime::Util::GMP qw(is_prime factor); # very fast!

print &home_prime(10),"\n";
#773

print &home_prime(16),"\n";
#31636373

print &home_prime(20),"\n";
#3318308475676071413

print &home_prime(48),"\n";
#6161791591356884791277

print &home_prime(65),"\n";
#1381321118321175157763339900357651

print &home_prime(96),"\n";
#172929671097972226356946608292031596899264419


sub home_prime {
	my ($n)=@_;
	is_prime($n) && return $n;
	return	&home_prime(join('',sort{$a<=>$b}(factor($n))));
}


1;

