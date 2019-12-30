#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.30);
use experimental qw(signatures);

# Write a script to display first 20 Leonardo Numbers. Please checkout
# https://en.wikipedia.org/wiki/Leonardo_number for more information.
#
# For example:
#
# L(0) = 1
# L(1) = 1
# L(2) = L(0) + L(1) + 1 = 3
# L(3) = L(1) + L(2) + 1 = 5
# and so on.

my $N = 20;

my ($l1, $l2) = (1,1);

for my $i (0..$N-1) {
    if ($i < 2) {
        say "L($i) = 1";
    } else {
        my $tmp = $l1 + $l2 + 1;
        say "L($i) = $tmp";
        ($l1, $l2) = ($l2, $tmp);
    }
}

