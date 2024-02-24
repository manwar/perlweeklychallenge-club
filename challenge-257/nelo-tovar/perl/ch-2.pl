#!/usr/bin/env perl

# The Weekly Challenge 257 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-257/
#
# Task 2 - Reduced Row Echelon
#

use strict;
use warnings;
use v5.28;
use List::MoreUtils qw /before first_value first_index/;
use Data::Dump qw(dump);

my @examples = (
			[
                  [1, 1, 0],
                  [0, 1, 0],
                  [0, 0, 0]
            ],
			[
                  [0, 1,-2, 0, 1],
                  [0, 0, 0, 1, 3],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0]
            ],
            [
                  [1, 0, 0, 4],
                  [0, 1, 0, 7],
                  [0, 0, 1,-1]
            ],
			[
                  [0, 1,-2, 0, 1],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 1, 3],
                  [0, 0, 0, 0, 0]
            ],
			[
                  [0, 1, 0],
                  [1, 0, 0],
                  [0, 0, 0]
            ],
			[
                  [4, 0, 0, 0],
                  [0, 1, 0, 7],
                  [0, 0, 1,-1]
            ]
);

sub get_pivot {
    my $array = shift;
    my $length = scalar @$array;

    return first_value {$_ > 0} @$array;

}

sub reduce_row_echelon {
    my $nums = shift;
    my $rows = scalar @$nums;
    my @pivots_index = ();
    my $zero_row;

    for (my $i = 0; $i < $rows; $i++) {
        my $a = @$nums[$i];
        my $pivot = get_pivot($a);

        if (! defined($pivot)){
            $zero_row = $i;
            next
        }
        
        return 0 if ( defined($zero_row) );
        return 0 if ( $pivot != 1 );

        my $pivot_index = first_index {$_ == $pivot} @$a;
        push @pivots_index, $pivot_index;

        for (my $j = 0; $j < $rows; $j++) {
            next if ( $j eq $i );
            return 0 if (@$nums[$j]->[$pivot_index] != 0 ); 
        }
    }

    for (my $i = 0; $i < @pivots_index - 1; $i++) {
        return 0 if ( $pivots_index[$i] >= $pivots_index[$i + 1] );
    }
     
    return 1;
}

for my $elements (@examples) {
    my $rre = reduce_row_echelon $elements;

    say 'Input : $M = [ ';
    foreach my $x (@$elements) {
        say	' ' x 15, dump(@$x);
    }
    say '             ]';
    say 'Output : ', $rre;
    say ' ';
}
