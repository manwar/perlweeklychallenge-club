#!/usr/bin/env perl

# The Weekly Challenge 252 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-252/
#
# Task 2 - Unique Sum Zero
#

use strict;
use warnings;
use v5.28;
use List::Util qw (min max);
use Data::Dump qw(dump);

my @examples = ( 5, 3, 1 , );

sub unique_sum_zero {
    my $n = shift;
    my @numbers = ();

    push @numbers,0 if ($n % 2 != 0) or ($n == 1);

    for (my $k = 1; $k <= $n / 2; $k++) {
        my $i = int rand(9) + 1;
        push @numbers, ($i, -$i)
    }
     
    return \@numbers;
}

for my $elements (@examples) {
    my $usz = unique_sum_zero $elements;

    say 'Input : $s = ', $elements;
    say 'Output : ', dump($usz);
    say ' ';
}
