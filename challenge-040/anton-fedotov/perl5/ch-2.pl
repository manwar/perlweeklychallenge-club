#!/usr/bin/env perl

##################################################
#      Perl Weekly Challenge 040, Chapter 2      #
##################################################

use strict;
use warnings;
use v5.10;

my @numbers = (10, 4, 1, 8, 12, 3);
my @indices = (0, 2, 5);

say join ' ', @numbers;

my @arr;
push @arr, $numbers[$_] for @indices;
@arr = sort {$a <=> $b} @arr;

for (@indices) {
    state $i = 0;
    $numbers[$_] = $arr[$i++];
}

say join ' ', @numbers;
