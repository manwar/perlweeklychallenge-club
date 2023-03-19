#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 208 Task 2: Duplicate and Missing
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;

use List::Util qw( reduce );

sub dup_and_missing {
    my ( $dup, $missing );
    reduce {
        $dup     = $b     if $a == $b;
        $missing = $b - 1 if $a < $b - 1;
        $b;
    } @_;
    return
        defined $dup
        ? ( $dup, $missing // ( $_[-1] + 1 ) )
        : -1;
}

use Test::More;

do {
    is_deeply [ dup_and_missing( @{$_->{INPUT}} ) ], $_->{EXPECTED},
        "dup_and_missing(" . join( ",", @{$_->{INPUT}} ) . ") == "
        . ( @{$_->{EXPECTED}} > 1
            ? ( "(" . join( ",", @{$_->{EXPECTED}} ) . ")" )
            : $_->{EXPECTED}->[0] );
} for (
    { INPUT => [ 1,2,2,4 ], EXPECTED => [ 2,3 ] },
    { INPUT => [ 1,2,3,4 ], EXPECTED => [ -1 ]},
    { INPUT => [ 1,2,3,3 ], EXPECTED => [ 3,4 ] },
    { INPUT => [ 11,12,12,13,15,16,17 ], EXPECTED => [ 12,14 ] },
);

done_testing;
