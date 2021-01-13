#!/bin/env perl
#""" Perl Weekly challenge 077 Task 2 """
#""" https://perlweeklychallenge.org/blog/perl-weekly-challenge-077/ """
#""" Solution Lubos Kolouch """
use strict;
use warnings;
use feature qw/say/;

sub is_position_lone {
    my ($args) = shift;

    my $matrix = $args->{matrix};
    my $pos_x  = $args->{pos_x};
    my $pos_y  = $args->{pos_y};

    for my $d_x ( -1, 0, 1 ) {
        for my $d_y ( -1, 0, 1 ) {
            next if $d_x == 0 and $d_y == 0;

            next if ( $pos_x + $d_x < 0 ) or ( $pos_x + $d_x >= scalar @$matrix );
            next if ( $pos_y + $d_y < 0 ) or ( $pos_y + $d_y >= scalar @$matrix );

            return 0 if $matrix->[ $pos_x + $d_x ][ $pos_y + $d_y ] eq 'X';
        }
    }

    return 1;
}

sub count_lone {

    #""" count the occurences of lone X """

    my $solution_count = 0;
    my $matrix         = shift;

    for my $pos_x ( 0 .. scalar @$matrix - 1 ) {
        for my $pos_y ( 0 .. scalar @$matrix - 1 ) {

            next if $matrix->[$pos_x][$pos_y] eq "O";

            $solution_count++ if is_position_lone({ matrix => $matrix, pos_x => $pos_x, pos_y => $pos_y } );
        }
    }

    return $solution_count;
}

use Test::More;

is( count_lone( [ [ 'O', 'O', 'X' ], [ 'X', 'O', 'O' ], [ 'X', 'O', 'O' ] ] ), 1 );
is(
    count_lone(
        [ [ 'O', 'O', 'X', 'O' ], [ 'X', 'O', 'O', 'O' ], [ 'X', 'O', 'O', 'X' ], [ 'O', 'X', 'O', 'O' ] ]
    ),
    2
);

done_testing;
