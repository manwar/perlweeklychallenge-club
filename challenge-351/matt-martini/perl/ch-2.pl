#!/usr/bin/env perl

# You are given an array of numbers.
# Write a script to return true if the given array can be re-arranged
# to form an arithmetic progression, otherwise return false.

#     A sequence of numbers is called an arithmetic progression if the
#     difference between any two consecutive elements is the same.

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

sub arithmetic_progression {
    my (@num) = @_;
    print 'Input: @num = (' . join( ', ', @num ) . ")\n";

    @num = sort { $a <=> $b } @num;
    my $diff = $num[1] - $num[0];

    my $result = 'true';
    COMPARE:
    foreach ( my $i = 1; $i <= $#num; $i++ ) {
        if ( $num[ $i - 1 ] + $diff != $num[$i] ) {
            $result = 'false';
            last COMPARE;
        }
    }

    say 'Output: ' . $result;
    return $result;
}

is( arithmetic_progression( ( 1,    3, 5, 7,   9 ) ),  'true',  'example 1' );
is( arithmetic_progression( ( 9,    1, 7, 5,   3 ) ),  'true',  'example 2' );
is( arithmetic_progression( ( 1,    2, 4, 8,   16 ) ), 'false', 'example 3' );
is( arithmetic_progression( ( 5,   -1, 3, 1,   -3 ) ), 'true',  'example 4' );
is( arithmetic_progression( ( 1.5,  3, 0, 4.5, 6 ) ),  'true',  'example 5' );
