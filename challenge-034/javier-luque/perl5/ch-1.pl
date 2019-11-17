#!/usr/bin/perl
# Test: ./ch1.pl
use strict;
use warnings;
use feature qw /say/;

my @array = (0,1,2,3,4,5,6,7,8,9);
my %hash  = (a => 1, b => 2, c => 3, d => 4);

say 'Array slice: ' . join ' ', @array[0..5];
say 'Hash slice: ' . join ' ', @hash{'a','b'};
