#!/usr/bin/env perl

use strict;
use warnings;
use v5.10;

my $M = shift @ARGV || 10;

#slow();
fast();

# this works but is very slow for large $M
# as its roughly O(n**2)
sub slow {
    my @a = (0);
    for my $n (0..$M) {
        my $r = 0;
        foreach my $m (0..($n-1)) {
            last if ! defined $a[$n];
            $r = $n - $m if $a[$m] == $a[$n];
        }
        $a[$n + 1] = $r;
        say $a[$n];
    }
}

# this is much faster for large $M
# by caching the last time we say a given number
# so its roughly O(n**2) but requires roughly O(2n) space
sub fast {
    my @a = (0);
    my @last = ();
    for my $n (0..$M) {
        my $m = $last[ $a[$n] ];
        my $r = defined $m ? $n - $m : 0;
        $last[$a[$n]] = $n;
        $a[$n + 1] = $r;
        say $a[$n];
    }
}
