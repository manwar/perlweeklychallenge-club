#!/usr/bin/env perl
#
# ch-1.pl - 2-Brilliant numbers
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

say for brilliant($ARGV[0] // 20);

# Return the first $count 2-Brilliant numbers
# This works like a prime sieve, but for every power of 10, we
# add another step of combining factors to make brilliant numbers
sub brilliant {
    my $count = $_[0];

    my @comp = (undef, 1, undef); # Composite numbers
    my @brilliant;                # Results

    for (my $lim = 10; $count > 0; $lim .= '0') {
        # Partial sieve
        for my $n (2..$lim) {
            next if $n > 2 and $comp[$n];
            $comp[$_] = $_ for map { $n * $_ } 2..$lim/$n;
        }

        # Pull out prime factors between $lim/10 and $lim
        my @fac = grep { !$comp[$_] } ($lim/10)..$lim;

        # Map all unique 2-permutations of prime factors $lim/10..$lim
        while (my ($i1, $n1) = each @fac) {
            push @brilliant, $n1 * $_ for @fac[$i1..$#fac];
            $count -= @fac - $i1;
        }
    }

    (sort { $a <=> $b } @brilliant)[0..$_[0]-1]
}
