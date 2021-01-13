#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);

no warnings 'experimental::signatures';

use List::Util qw(min max);
use Test::More tests => 3;

{

    my @test_data = (
        [
            [ 2, 6 ],    #
            [ [ 1, 4 ], [ 8, 10 ] ],
            [ [ 1, 6 ], [ 8, 10 ] ],

        ],
        [
            [ 5, 8 ],    #
            [ [ 1, 2 ], [ 3, 7 ], [ 8, 10 ] ],
            [ [ 1, 2 ], [ 3, 10 ] ],
        ],
        [
            [ 10, 11 ],    #
            [ [ 1, 5 ], [ 7, 9 ], ],
            [ [ 1, 5 ], [ 7, 9 ], [ 10, 11 ] ],

        ],
    );

    for my $test ( @test_data ) {
        my ( $n, $s, $expect ) = @$test;
        my $merged = merge_intervals( $n, $s );
        is_deeply(
            $merged, $expect,
            join( ' ',
                render_intervals( $s ),
                'merged with', render_intervals( [$n] ),
                'is', render_intervals( $expect ) )
        );

    }

}

# O(length $s) solultion.
sub merge_intervals ( $n, $s ) {

    my @merged;
    my $used = 0;

    for my $interval ( @$s ) {
        if ( overlap( $n, $interval ) ) {

            # there is some overlap in $n and $interval. This means, that some merging hast to be done.
            if ( !$used ) {

                # if we didn't use $n yet we create a new interval that spans both $n and $interval
                push @merged, [ min( $interval->[0], $n->[0] ), max( $interval->[1], $n->[1] ) ];
                $used = 1;
            }
            else {
                # $n has already been used. due to the fact, that our input was sorted, there can't be any gaps between
                # overlapping elements and we extend the last interval we pushed to @merged by setting its end to the
                # end of the current interval
                $merged[-1][1] = $interval->[1];
            }
        }
        else {    # there is is no overlap. we will use $interval unaltered.
            if ( !$used && $interval->[1] > $n->[1] ) {

                # we walked past the end of $n and haven't used it yet. This means it belongs right before $interval
                push @merged, $n;
                $used = 1;
            }
            push @merged, $interval;
        }
    }

    # $n wasn't used at all. it belongs to the end of @merged
    push @merged, $n unless $used;

    return \@merged;
}

# returns wether $a and $b overlap in any way
sub overlap ( $a, $b ) {
    my ( $a_start, $a_end ) = @$a;
    my ( $b_start, $b_end ) = @$b;

    ( $a_start <= $b_end && $a_start >= $b_start )
      || ( $a_end >= $b_start && $a_end <= $b_end )
      || ( $a_end > $b_end && $a_start < $b_end );

}

sub render_intervals($n) {
    join( ", ", map { '(' . join( ',', @$_ ) . ')' } @$n );
}
