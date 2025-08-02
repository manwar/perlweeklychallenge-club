#!/usr/bin/env perl

# The Weekly Challenge 276 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-276/
#
# Task 1 - Complete Day
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    [ 12, 12, 30, 24, 24 ],
    [ 72, 48, 24, 5 ],
    [ 12, 18, 24 ],
);

sub complete_day {
    my $hours = shift;
    my $length = scalar @$hours;
    my $amount = 0;

    for (my $i = 0; $i < $length - 1; $i++) {
        for (my $j = $i + 1; $j < $length; $j++) {
            $amount++ if ( ($hours->[$i] + $hours->[$j]) % 24 eq 0)     
        }
    }
    
    return $amount;
}

for my $elements (@examples) {
    my $cd = complete_day $elements;

    say 'Input : @hours = ', dump(@$elements);
    say 'Output : ', $cd;
    say ' ';
}
