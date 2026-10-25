#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 396 Task 2: Trionic Array
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::MoreUtils qw( slide );
use List::Util::Uniq qw( uniq_adj );

sub trionic_array_using_modules( @arr ) {
    return join( " ", uniq_adj slide { $a <=> $b } @arr )
           eq "-1 1 -1";
}

sub trionic_array( @arr ) {
    my ( $prev_value, $prev_compare ) = ( $arr[0], "" );
    return join( " ",
        map {
            my $compare = $prev_value <=> $_;
            $prev_value = $_;
            $compare ne $prev_compare ? ( $prev_compare = $compare ) : ();
        } @arr[1..$#arr] )
        eq "-1 1 -1";
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", [1, 3, 5, 4, 2, 6, 8], T ],
    [ "Example 2", [1, 4, 4, 2, 1, 3, 5], F ],
    [ "Example 3", [2, 10, 3, 1, 9], T ],
    [ "Example 4", [1 .. 4, 3, 2, 1], F ],
    [ "Example 5", [1, 3, 2, 4, 1, 5, 2], F ],
);

is trionic_array( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;

done_testing;
