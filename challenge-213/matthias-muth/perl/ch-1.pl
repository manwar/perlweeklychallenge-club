#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 213 Task 1: Fun Sort
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

sub fun_sort {
    sort { $a % 2 <=> $b % 2 || $a <=> $b } @_;
}

use Test::More;
use Data::Dump qw( pp );

do {
    is_deeply [ fun_sort( @{$_->{INPUT}} ) ], $_->{EXPECTED},
        "fun_sort( " . pp( @{$_->{INPUT}} ) . " ) == " . pp( @{$_->{EXPECTED}} );
} for (
    { INPUT => [ 1,2,3,4,5,6 ], EXPECTED => [ 2,4,6,1,3,5 ] },
    { INPUT => [ 1,2 ], EXPECTED => [ 2,1 ] },
    { INPUT => [ 1 ], EXPECTED => [ 1 ] },
);

done_testing;
