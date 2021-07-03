#!/usr/bin/perl
# The Weekly Challenge - 119
# Task 2 Sequence without 1-on-1
use strict;
use warnings;

my $N = $ARGV[0];

my @arr = (0,1,2,3);

my $x = 0, my $y;

while ($#arr < $N) {
    $y = $#arr;
    for my $here ($x+1..$y) {
        push @arr, $arr[$here]."1" 
            if substr($arr[$here], -1, 1) ne "1";
        push @arr, $arr[$here]."2";
        push @arr, $arr[$here]."3";
    }
    $x = $y;
}
   

print $arr[$N], "\n";
