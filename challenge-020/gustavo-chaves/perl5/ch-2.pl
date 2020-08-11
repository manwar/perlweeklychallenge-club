#!/usr/bin/env perl

# Write a script to print the smallest pair of Amicable Numbers. For more
# information, please checkout wikipedia page:
# https://en.wikipedia.org/wiki/Amicable_numbers.

use 5.026;
use strict;
use warnings;
use Math::Prime::Util qw/divisor_sum/;
use Memoize;

memoize('divisor_sum');

for (my $n=2; ; ++$n) {
    my $pds = divisor_sum($n) - $n;
    next if $n == $pds;

    my $pds_pds = divisor_sum($pds) - $pds;
    next if $n != $pds_pds;

    say "$n $pds";
    last;
}
