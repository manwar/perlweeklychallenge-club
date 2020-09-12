#!/bin/env perl
#""" Perl Weekly challenge 077 Task 2 """
#""" https://perlweeklychallenge.org/blog/perl-weekly-challenge-077/ """
#""" Solution Lubos Kolouch """
use strict;
use warnings;
use feature qw/say/;

sub count_lone {
    #""" count the occurences of lone X """
    
    my $solution_count = 0;
    my $matrix = shift;

    for my $line_nr ( 0 .. scalar @$matrix - 1 ) {
        for my $col_nr ( 0 .. scalar @$matrix - 1 ) {

            next if $matrix->[$line_nr][$col_nr] eq "O";

            my $is_lone = 1;
            for my $d_x ( -1, 0, 1 ) {
                for my $d_y ( -1, 0, 1 ) {
                    next if $d_x == 0 and $d_y == 0;

                    next if ( $line_nr + $d_x < 0 ) or ( $line_nr + $d_x >= scalar @$matrix );
                    next if ( $col_nr + $d_y < 0 )  or ( $col_nr + $d_y >= scalar @$matrix );

                    if ( $matrix->[ $line_nr + $d_x ][ $col_nr + $d_y ] eq 'X' ) {
                        $is_lone = 0;
                        last;
                    }
                }
            }
            $solution_count += 1 if $is_lone;
        }
    }

    return $solution_count;
}


use Test::More;

is( count_lone([['O', 'O', 'X'], ['X', 'O', 'O'], ['X', 'O', 'O']]), 1);
is( count_lone([['O', 'O', 'X', 'O'], ['X', 'O', 'O', 'O'], ['X', 'O', 'O', 'X'], ['O', 'X', 'O', 'O']]), 2);

done_testing;
