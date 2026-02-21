#!/usr/bin/env perl

# You are given a binary matrix (m x n).

# Write a script to find the celebrity, return -1 when none found.

#     A celebrity is someone, everyone knows and knows nobody.

use 5.018;
use strict;
use warnings;
use Test2::V0;
use List::Util qw(sum);

plan tests => 6;

sub print_matrix {
    my @matrix = @{ $_[0] };
    for my $row (@matrix) {
        say "\t    [ ", join( " ", @$row ), ' ]';
    }
    return;
}

sub find_celebrity {
    my (@party) = @{ $_[0] };

    say 'Input: @party = (';
    print_matrix( \@party );
    say "\t);";

    my $result = -1;

    ROW:
    for my $row ( 0 .. $#party ) {
        my $sum = sum @{ $party[$row] };
        next ROW unless ( $sum == 0 );
        my $colsum = 1;
        COL:
        for my $rw ( 0 .. $#party ) {
            next COL if ( $rw == $row );
            $colsum &= $party[$rw]->[$row];
        }
        if ( $colsum == 1 ) {
            $result = $row;
            last ROW;
        }
    }

    say 'Output: ' . $result;
    return $result;
}

my @examples = (

                {  in => [ [ 0, 0, 0, 0, 1, 0 ],    # 0 knows 4
                           [ 0, 0, 0, 0, 1, 0 ],    # 1 knows 4
                           [ 0, 0, 0, 0, 1, 0 ],    # 2 knows 4
                           [ 0, 0, 0, 0, 1, 0 ],    # 3 knows 4
                           [ 0, 0, 0, 0, 0, 0 ],    # 4 knows NOBODY
                           [ 0, 0, 0, 0, 1, 0 ],    # 5 knows 4
                         ],
                   out  => 4,
                   name => 'example 1'
                },

                {  in => [ [ 0, 1, 0, 0 ],          # 0 knows 1
                           [ 0, 0, 1, 0 ],          # 1 knows 2
                           [ 0, 0, 0, 1 ],          # 2 knows 3
                           [ 1, 0, 0, 0 ]           # 3 knows 0
                         ],
                   out  => -1,
                   name => 'example 2'
                },

                {  in => [ [ 0, 0, 0, 0, 0 ],       # 0 knows NOBODY
                           [ 1, 0, 0, 0, 0 ],       # 1 knows 0
                           [ 1, 0, 0, 0, 0 ],       # 2 knows 0
                           [ 1, 0, 0, 0, 0 ],       # 3 knows 0
                           [ 1, 0, 0, 0, 0 ]        # 4 knows 0
                         ],
                   out  => 0,
                   name => 'example 3'
                },

                {  in => [ [ 0, 1, 0, 1, 0, 1 ],    # 0 knows 1, 3, 5
                           [ 1, 0, 1, 1, 0, 0 ],    # 1 knows 0, 2, 3
                           [ 0, 0, 0, 1, 1, 0 ],    # 2 knows 3, 4
                           [ 0, 0, 0, 0, 0, 0 ],    # 3 knows NOBODY
                           [ 0, 1, 0, 1, 0, 0 ],    # 4 knows 1, 3
                           [ 1, 0, 1, 1, 0, 0 ]     # 5 knows 0, 2, 3
                         ],
                   out  => 3,
                   name => 'example 4'
                },

                {  in => [ [ 0, 1, 1, 0 ],          # 0 knows 1 and 2
                           [ 1, 0, 1, 0 ],          # 1 knows 0 and 2
                           [ 0, 0, 0, 0 ],          # 2 knows NOBODY
                           [ 0, 0, 0, 0 ]           # 3 knows NOBODY
                         ],
                   out  => -1,
                   name => 'example 5'
                },
                {  in => [ [ 0, 0, 1, 1 ],          # 0 knows 2 and 3
                           [ 1, 0, 0, 0 ],          # 1 knows 0
                           [ 1, 1, 0, 1 ],          # 2 knows 0, 1 and 3
                           [ 1, 1, 0, 0 ]           # 3 knows 0 and 1
                         ],
                   out  => -1,
                   name => 'example 6'
                },
               );

is( find_celebrity( $_->{ in } ), $_->{ out }, $_->{ name } ) for @examples;

