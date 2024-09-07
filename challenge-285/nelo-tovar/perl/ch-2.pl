#!/usr/bin/env perl

# The Weekly Challenge 285 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-285/
#
# Task 2 - Making Change
#

use strict;
use warnings;
use v5.28;
use List::Util qw (min max);
use Algorithm::Combinatorics qw(combinations);
use Data::Dump qw(dump);

my @examples = (  9, 15, 100 );

sub making_change {
    my $amount = shift;
    my @coins = (1, 5, 10, 25, 50);
    my @changes = (1);
    
    foreach my $coin (@coins){
        for my $i (0 .. $amount - $coin){
            $changes[$i + $coin] += $changes[$i];
        }
    }

    return $changes[$amount]
}

for my $elements (@examples) {
    my $mc = making_change $elements;

    say 'Input : $amount = ', $elements;
    say 'Output : ', $mc;
    say ' ';
}
