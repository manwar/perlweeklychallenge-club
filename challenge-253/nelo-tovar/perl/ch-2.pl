#!/usr/bin/env perl

# The Weekly Challenge 253 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-253/
#
# Task 2 - Weakest Row
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);
use List::Util qw/sum0/;

my @examples = (
    [
          [1, 1, 0, 0, 0],
          [1, 1, 1, 1, 0],
          [1, 0, 0, 0, 0],
          [1, 1, 0, 0, 0],
          [1, 1, 1, 1, 1]
    ],
    [
          [1, 0, 0, 0],
          [1, 1, 1, 1],
          [1, 0, 0, 0],
          [1, 0, 0, 0]
    ]
);

sub weakest_row {
    my $matrix = shift;
    my $cols = scalar @$matrix;
    my @rows = ();
    my %sum_rows;

    for (my $i = 0; $i < $cols; $i++) {
       $sum_rows{$i} = sum0 @{$matrix->[$i]};
    }   

    @rows = sort { $sum_rows{$a} <=> $sum_rows{$b} } sort keys %sum_rows;

    return \@rows;
}

for my $elements (@examples) {
    my $wr = weakest_row $elements;

    say 'Input : $matrix = [';
    foreach my $x (@$elements) {
        printf("%19s%s,\n", ' ', dump($x))
    };
    printf("%18s\n", ']');
    say 'Output : ', dump($wr);
    say ' ';
}
