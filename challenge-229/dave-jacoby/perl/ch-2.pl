#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw( uniq );

my @examples = (

    [ [ 1, 1, 2, 4 ],    [ 2, 4 ],          [4], ],
    [ [ 4, 1 ],          [ 2, 4 ],          [ 1, 2 ], ],
    [ [ 9, 0, 1, 2, 5 ], [ 9, 0, 2, 1, 0 ], [ 1, 9, 8, 4 ], ],
);

for my $e (@examples) {
    my @array  = $e->@*;
    my @output = two_out_of_three(@array);
    my $output = join ', ', @output;

    my $array1 = join ', ', $array[0]->@*;
    my $array2 = join ', ', $array[1]->@*;
    my $array3 = join ', ', $array[2]->@*;

    say <<~"END";
    Input:  \@array1 = ($array1)
            \@array2 = ($array2)
            \@array3 = ($array3)
    Output: ($output)
    END
}

sub two_out_of_three (@array) {
    my %hash;
    for my $s (@array) {
        my @sub = $s->@*;
        my @mid = uniq @sub;
        for my $int (@mid) {
            $hash{$int}++;
        }
    }
    return sort grep { $hash{$_} > 1 } keys %hash;
}
