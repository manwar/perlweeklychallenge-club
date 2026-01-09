#!/usr/bin/env perl

# You are given an array of distinct integers.

# Write a script to find all pairs of elements with the minimum absolute difference.
#   Rules (a,b):
#   1: a, b are from the given array.
#   2: a < b
#   3: b - a = min abs diff any two elements in the given array

use 5.018;
use strict;
use warnings;
use Test2::V0;
use List::Util::Find qw(hasstr);
use Data::Dump qw(pp);

plan tests => 5;

sub min_abs_diff {
    my (@ints) = @_;
    print 'Input: @ints = (' . join( ', ', @ints ) . ")\n";

    my @sorted_ints = sort { $a <=> $b } (@ints);

    my @results;
    my $min_diff = "inf";
    COMPARE:
    foreach my $i ( 0 .. $#sorted_ints - 1 ) {
        my $diff = $sorted_ints[ $i + 1 ] - $sorted_ints[$i];
        if ( $diff > $min_diff ) {
            next COMPARE;
        }
        if ( $diff < $min_diff ) {
            $min_diff = $diff;
            @results  = ();
        }
        push @results, [ $sorted_ints[$i], $sorted_ints[ $i + 1 ] ];
    }

    print 'Output: ';
    pp @results;
    return \@results;
}

is(
    min_abs_diff( ( 4, 2, 1, 3 ), ),
    [ [ 1, 2 ], [ 2, 3 ], [ 3, 4 ] ],
    'example 1'
  );

is(
    min_abs_diff( ( 10, 100, 20, 30 ), ),
    [ [ 10, 20 ], [ 20, 30 ] ],
    'example 2'
  );

is( min_abs_diff( ( -5, -2, 0, 3 ), ), [ [ -2, 0 ], ], 'example 3' );

is( min_abs_diff( ( 8, 1, 15, 3 ), ), [ [ 1, 3 ], ], 'example 4' );

is(
    min_abs_diff( ( 12, 5, 9, 1, 15 ), ),
    [ [ 9, 12 ], [ 12, 15 ], ],
    'example 5'
  );

