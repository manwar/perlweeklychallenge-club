#!/usr/bin/env perl6

my @p  = lazy gather { my $x = 0; loop { take $x if (++$x).is-prime } }
my @sp = lazy gather { my $y = 0; loop { $y++; take @p[$y] if @p[$y] > ( @p[$y-1] + @p[$y+1] ) / 2 } }
my @wp = lazy gather { my $z = 0; loop { $z++; take @p[$z] if @p[$z] < ( @p[$z-1] + @p[$z+1] ) / 2 } }

print "Strong primes: ";
for 0..9 -> $n { print "@sp[$n] " };
print "\nWeak primes: ";
for 0..9 -> $n { print "@wp[$n] " };
