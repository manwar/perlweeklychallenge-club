#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge #84
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-084/
#               Task 2 - Find Square
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 10/30/2020 08:48:14 PM
#===============================================================================

use strict;
use warnings;
use List::Util qw/min/;
use feature qw/say/;

sub get_square_count {

    my $matrix = shift;

    # we will use the lengths so let's cache them for code readability
    my $m = scalar @$matrix;
    my $n = scalar @{$matrix->[0]};

    my $counter = 0;

    # no need to scan the last row and column
    for my $i (0..$m - 1) {
        for my $j (0..$n - 1) {
            # don't bother if we are at 0

            next unless $matrix->[$i][$j];
            # check the possible lengths
            # it's a square so need just the smaller distance
            for my $k (1..min($m - $i, $n - $j)) {
                # check if the corners are 1
                $counter++ if ($matrix->[$i][$j+$k]) and ($matrix->[$i+$k][$j]) 
                            and ($matrix->[$i+$k][$j+$k]);
            }
        }
    }
    return $counter;
}

use Test::More;

is(get_square_count([[0, 1, 0, 1], [0, 0, 1, 0], [1, 1, 0, 1], [1, 0, 0, 1]]), 1);
is(get_square_count([[1, 1, 0, 1], [1, 1, 0, 0], [0, 1, 1, 1], [1, 0, 1, 1]]), 4);
is(get_square_count([[0, 1, 0, 1], [1, 0, 1, 0], [0, 1, 0, 0], [1, 0, 0, 1]]), 0);

done_testing;

