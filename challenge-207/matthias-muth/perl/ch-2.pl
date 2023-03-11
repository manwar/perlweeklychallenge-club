#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 207 Task 2: H-Index
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;

sub h_index {
    my @sorted = sort { $b <=> $a } @_;
    return scalar grep $sorted[$_] >= 1 + $_, 0..$#sorted;
}

use Test::More;

do {
    is h_index( @{$_->{INPUT}} ), $_->{EXPECTED},
        "h_index( @{$_->{INPUT}} ) == $_->{EXPECTED}";
} for (
    { INPUT => [ 10,8,5,4,3 ], EXPECTED => 4 },
    { INPUT => [ 25,8,5,3,3 ], EXPECTED => 3 },
);

done_testing;
