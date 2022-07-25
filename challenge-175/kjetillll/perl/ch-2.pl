#!/usr/bin/perl
# prints the first 20 Perfect Totient Numbers:
# 3 9 15 27 39 81 111 183 243 255 327 363 471 729 2187
# https://theweeklychallenge.org/blog/perl-weekly-challenge-175/
# https://en.wikipedia.org/wiki/Perfect_totient_number
# use Math::Prime::Util::GMP 'gcd';     # ...is faster, but not a core module
# use Math::Prime::Util::GMP 'totient'; # ...is screamingly fast!

use strict; use warnings;
use Memoize;
memoize('totient');  #good idea, unless using GMP
#memoize('gcd');     #bad idea, runs slower

sub totient { my $n=shift; 0+grep gcd($_,$n)==1, 1..$n-1 }

sub gcd { my($a,$b)=@_;($a,$b)=($b,$a)if$a>$b;($a,$b)=($b%$a,$a)while$a;$b }

my $want = shift() // 20;
my $try = 1;
while( $want > 0 ){
    my $sum = 0;
    my $n = $try;
    $sum += $n = totient($n) while $n>1;
    print "$try\n" and $want-- if $sum == $try;
    $try+=2;
}

