#!/usr/bin/perl
use warnings; use strict; use v5.10;
use Math::Prime::Util 'is_prime';

my $want = 20;
/^(([1-9])(?1)\2|0)$/ and is_prime($_) and say and --$want||exit while ++$_;

__END__
https://theweeklychallenge.org/blog/perl-weekly-challenge-177/

The recursive regex above is true for palindromic positive integers, which
reads the same backward as forward, which is also "cyclopsic" (one eyed)
with one and only one zero digit which must be in the middle.

Output:

101
16061
31013
35053
38083
73037
74047
91019
94049
1120211
1150511
1160611
1180811
1190911
1250521
1280821
1360631
1390931
1490941
1520251
