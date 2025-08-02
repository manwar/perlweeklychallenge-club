#!/usr/bin/env perl

# The Weekly Challenge 276 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-276/
#
# Task 2 - Maximum Frequency
#

use strict;
use warnings;
use v5.28;
use List::Util qw (max);
use List::MoreUtils qw (frequency);
use Data::Dump qw(dump);

my @examples = (
    [ 1, 2, 2, 4, 1, 5 ],
    [ 1, 2, 3, 4, 5 ]
);

sub maximum_frecuency {
    my $ints = shift;
    my %frecuency = frequency @$ints;
    my $max = max values %frecuency;
    my $amount = 0;

    foreach my $k (@$ints) {
        $amount++ if ($frecuency{$k} eq $max)
    }
     
    return $amount;
}

for my $elements (@examples) {
    my $mf = maximum_frecuency $elements;

    say 'Input : @ints = ', dump(@$elements);
    say 'Output : ', $mf;
    say ' ';
}
