#!/usr/bin/env perl

# The Weekly Challenge 266 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-266/
#
# Task 2 - X Matrix
#

use strict;
use warnings;
use v5.28;
use List::Util qw (min max);
use Algorithm::Combinatorics qw(combinations);
use Data::Dump qw(dump);

my @examples = (
    [ [1, 0, 0, 2],
      [0, 3, 4, 0],
      [0, 5, 6, 0],
      [7, 0, 0, 1], 
    ],
    [ [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9], 
    ],
    [ [1, 0, 2],
      [0, 3, 0],
      [4, 0, 5], 
    ],
);

sub x_matrix {
    my $matrix = shift;
    my $length = scalar @$matrix;

    for (my $i = 0; $i < $length; $i++) {
        for (my $j = 0; $j < $length; $j++) {
            if ($i == $j || $j == ($length - $i - 1)){
                return 'false' if ($matrix->[$i][$j] == 0);
            }elsif ($matrix->[$i][$j] != 0){
                return 'false'
            }
        }
    }
     
    return 'true';
}

for my $elements (@examples) {
    my $xm = x_matrix $elements;

    say 'Input : matrix = [';
    foreach my $x (@$elements) {
        printf "%s%s,\n", ' 'x18,dump($x);
    };
    say '                 ]';
    say 'Output : ', $xm;
    say ' ';
}
