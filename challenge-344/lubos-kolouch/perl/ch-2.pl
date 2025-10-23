#!/usr/bin/env perl

# Perl Weekly Challenge: Task 2 - Array Formation
# Determine whether the target array can be formed by concatenating source subarrays without reordering their elements.

use strict;
use warnings;
use v5.30;

# Enable signatures for clarity.
use experimental 'signatures';

# Check if @target can be built by reordering the subarrays in @source and concatenating them.
## no critic (Subroutines::ProhibitSubroutinePrototypes)
sub array_formation ( $source_ref, $target_ref ) {
    my @source        = $source_ref->@*;
    my @target        = $target_ref->@*;
    my $target_length = @target;
    my @used          = (0) x @source;
    my $index         = 0;

    while ( $index < $target_length ) {
        my $matched = 0;

        for my $i ( 0 .. $#source ) {
            next if $used[$i];
            my @piece = $source[$i]->@*;
            next unless @piece;
            next unless $piece[0] == $target[$index];

            my $len = @piece;
            next if $index + $len > $target_length;

            my $fits = 1;
            for my $offset ( 0 .. $len - 1 ) {
                if ( $piece[$offset] != $target[ $index + $offset ] ) {
                    $fits = 0;
                    last;
                }
            }

            next unless $fits;

            $used[$i] = 1;
            $index += $len;
            $matched = 1;
            last;
        }

        return 'false' unless $matched;
    }

    return 'true';
}

# Unit tests
use Test::More;

is( array_formation( [ [ 2, 3 ], [1], [4] ], [ 1, 2, 3, 4 ] ),
    'true', 'Example 1: ([2,3],[1],[4]) -> (1,2,3,4)' );
is( array_formation( [ [ 1, 3 ], [ 2, 4 ] ], [ 1, 2, 3, 4 ] ),
    'false', 'Example 2: ([1,3],[2,4]) -> (1,2,3,4)' );
is( array_formation( [ [ 9, 1 ], [ 5, 8 ], [2] ], [ 5, 8, 2, 9, 1 ] ),
    'true', 'Example 3: ([9,1],[5,8],[2]) -> (5,8,2,9,1)' );
is( array_formation( [ [1], [3] ],    [ 1, 2, 3 ] ), 'false', 'Example 4: ([1],[3]) -> (1,2,3)' );
is( array_formation( [ [ 7, 4, 6 ] ], [ 7, 4, 6 ] ), 'true',  'Example 5: ([7,4,6]) -> (7,4,6)' );

done_testing();
