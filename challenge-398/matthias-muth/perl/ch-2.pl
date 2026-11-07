#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 398 Task 2: String Difference
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::MoreUtils qw( slide );

sub string_difference( @words ) {
    my %buckets;
    for my $word ( @words ) {
        my $signature =
            join ",", slide { ord( $b ) - ord( $a ) } split "", $word;
        push $buckets{$signature}->@*, $word;
    }
    return ( map $_->[0], grep $_->@* == 1, values %buckets )[0];
}

use Test2::V0 qw( -no_srand );


my @tests = (
    [ "Example 1", ["ab", "bc", "cd", "zy"], "zy" ],
    [ "Example 2", ["cba", "fed", "azy"], "azy" ],
    [ "Example 3", ["pop", "ada", "beb", "cfc"], "pop" ],
    [ "Example 4", ["aaaa", "zzzz", "mmmm", "aaba"], "aaba" ],
    [ "Example 5", ["aceg", "bdfh", "cegi", "azbz"], "azbz" ],
    [ "Own Test 1: no outlier", ["aceg", "bdfh", "cegi"], undef ],
    [ "Own Test 2: two outliers", ["aceg", "bdfh", "azbz", "bzbz" ],
        in_set( "azbz", "bzbz" ) ],
);

is string_difference( $_->[1]->@* ), $_->[2], $_->[0]
    for @tests;

done_testing;
