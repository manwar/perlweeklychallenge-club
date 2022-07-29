#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say state);
use Math::Prime::Util qw(factor_exp);
use List::Util qw(product);
use Time::HiRes qw(time);

my $c = 40;

my $t0 = time;
my $n = 1;
st(++$n)           - $n ? redo : say sprintf '%3d %10d %10.3f', $_, $n, time-$t0 for 1..$c;
my $t1 = time;
$n = 1;
sum_totients(++$n) - $n ? redo : say sprintf '%3d %10d %10.3f', $_, $n, time-$t1 for 1..$c;
my $t2 = time;

say '';
say sprintf 'One-liner - %10.6f', $t1-$t0;
say sprintf 'Expanded  - %10.6f %10.6f', $t2-$t1, 100*($t2-$t1)/($t1-$t0);

# If $n > 1 then the count of co-prime values is equal
# to the product of p^n-p^(n-1) for all prime factors
#      (where n is the number of times p is a factor)
# we can re-write this as p^(n-1)(p-1)
# As factor_exp is fast this removes the need to compute
# the gcd of every pair of numbers....
# we also keep track of the perfect totient numbers gone
# before so that we re-use the previously computed value
# if we already have it...;

sub st {
  state @T = (0,0);
  $T[ $_[0] ] //= sub{$_[0]+st($_[0])}->(
                  product
                    map { $_->[0]**($_->[1]-1) * ($_->[0]-1) }
                    factor_exp $_[0]);
}

sub sum_totients {
  state @T = (0,0);
  unless( defined $T[ $_[0] ] ) {
    my $z = 1;
    $z *= $_->[0]**($_->[1]-1) * ($_->[0]-1) for factor_exp $_[0];
    $T[ $_[0] ] = $z + sum_totients( $z );
  }
  $T[ $_[0] ];
}

