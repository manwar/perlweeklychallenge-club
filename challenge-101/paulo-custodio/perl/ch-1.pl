#!/usr/bin/perl

# Challenge 101
#
# TASK #1 › Pack a Spiral
# Submitted by: Stuart Little
#
# You are given an array @A of items (integers say, but they can be anything).
#
# Your task is to pack that array into an MxN matrix spirally counterclockwise,
# as tightly as possible.
#
# ‘Tightly’ means the absolute value |M-N| of the difference has to be as small
# as possible.

use strict;
use warnings;
use 5.030;

my @list = @ARGV;

my($m, $n) = smallest_rect(scalar(@list));
my @rect = spiral($m, $n, @list);

for my $r (1 .. $m) {
    for my $c (1 .. $n) {
        print $rect[$r][$c], " ";
    }
    say "";
}

sub smallest_rect {
    my($n) = @_;
    my $low = 1;
    my $high = $n;
    for (my $i = 1; $i*$i <= $n; $i++) {
        if (($n % $i) == 0) {
            $low = $i;
            $high = $n/$i;
        }
    }
    return ($low, $high);
}

sub spiral {
    my($m, $n, @list) = @_;

    # find max width of elements
    my $width = 1;
    for (@list) {
        $width = length($_) if length($_) > $width;
    }

    # build rectangle
    my @rect;
    my $r = $m; my $c = 1;
    while (@list) {
        # go East
        while (@list && $c <= $n && !defined($rect[$r][$c])) {
            $rect[$r][$c] = sprintf("%*s", $width, shift @list);
            $c++;
        }
        $c--; $r--;
        # go North
        while (@list && $r >= 1 && !defined($rect[$r][$c])) {
            $rect[$r][$c] = sprintf("%*s", $width, shift @list);
            $r--;
        }
        $r++; $c--;
        # go West
        while (@list && $c >= 1 && !defined($rect[$r][$c])) {
            $rect[$r][$c] = sprintf("%*s", $width, shift @list);
            $c--;
        }
        $c++; $r++;
        # go South
        while (@list && $r <= $m && !defined($rect[$r][$c])) {
            $rect[$r][$c] = sprintf("%*s", $width, shift @list);
            $r++;
        }
        $r--; $c++;
    }

    return @rect;
}
