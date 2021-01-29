#!/usr/bin/perl

# Challenge 079
#
# TASK #2 › Trapped Rain Water
# Submitted by: Mohammad S Anwar
# You are given an array of positive numbers @N.
#
# Write a script to represent it as Histogram Chart and find out how much water it can trap.
#
# Example 1:
# Input: @N = (2, 1, 4, 1, 2, 5)
# The histogram representation of the given array is as below.
#      5           #
#      4     #     #
#      3     #     #
#      2 #   #   # #
#      1 # # # # # #
#      _ _ _ _ _ _ _
#        2 1 4 1 2 5
# Looking at the above histogram, we can see, it can trap 1 unit of rain water between 1st and 3rd column. Similary it can trap 5 units of rain water betweem 3rd and last column.
#
# Therefore your script should print 6.
#
# Example 2:
# Input: @N = (3, 1, 3, 1, 1, 5)
# The histogram representation of the given array is as below.
#      5           #
#      4           #
#      3 #   #     #
#      2 #   #     #
#      1 # # # # # #
#      _ _ _ _ _ _ _
#        3 1 3 1 1 5
# Looking at the above histogram, we can see, it can trap 2 units of rain water between 1st and 3rd column. Also it can trap 4 units of rain water between 3rd and last column.
#
# Therefore your script should print 6.

use strict;
use warnings;
use 5.030;

@ARGV or die "Usage: ch-2.pl list\n";
my @N = @ARGV;

# draw histogram
my @hist = draw_hist(@N);

# count spaces between walls, replace them by 'x'
for (@hist) {
    1 while s/#( +)#/'#'.('x' x length($1)).'#'/e;
}

# count x
my $count = sum(map {tr/x/x/} @hist);

say $count;

sub draw_hist {
    my(@n) = @_;
    my $max = max(@n);
    my @hist;
    for my $row (0..$max-1) {
        my $n = $max-$row;
        my $line = '';
        for my $col (0..$#n) {
            $line .= $n[$col] >= $n ? '#' : ' ';
        }
        push @hist, $line;
    }
    return @hist;
}

sub max {
    my($max, @a) = @_;
    for (@a) {
        $max = $_ if $max < $_;
    }
    return $max;
}

sub sum {
    my($sum, @a) = @_;
    $sum += $_ for @a;
    return $sum;
}
