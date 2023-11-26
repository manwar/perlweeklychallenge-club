#!/usr/bin/perl
use 5.030;
use warnings;

my @arr1 = split q{, }, $ARGV[0];
my @arr2 = split q{, }, $ARGV[1];

say 0+((join q{}, @arr1) eq (join q{}, @arr2)) ? 'true' : 'false';