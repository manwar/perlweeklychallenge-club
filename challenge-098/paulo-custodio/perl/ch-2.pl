#!/usr/bin/perl

# Challenge 098
#
# TASK #2 › Search Insert Position
# Submitted by: Mohammad S Anwar
# You are given a sorted array of distinct integers @N and a target $N.
#
# Write a script to return the index of the given target if found
# otherwise place the target in the sorted array and return the index.
#
# Example 1:
# Input: @N = (1, 2, 3, 4) and $N = 3
# Output: 2 since the target 3 is in the array at the index 2.
# Example 2:
# Input: @N = (1, 3, 5, 7) and $N = 6
# Output: 3 since the target 6 is missing and should be placed at
# the index 3.
# Example 3:
# Input: @N = (12, 14, 16, 18) and $N = 10
# Output: 0 since the target 10 is missing and should be placed at
# the index 0.
# Example 4:
# Input: @N = (11, 13, 15, 17) and $N = 19
# Output: 4 since the target 19 is missing and should be placed at
# the index 4.

use strict;
use warnings;
use 5.030;

# use bisect method to search for position
sub search_insert {
    my($n, $N) = @_;
    if (!@$N) {                 # input empty
        push @$N, $n;
        return 0;
    }
    elsif ($n < $N->[0]) {      # before first
        unshift @$N, $n;
        return 0;
    }
    elsif ($n > $N->[-1]) {     # after last
        push @$N, $n;
        return $#$N;
    }
    else {                      # bisect
        my $b = 0; my $t = @$N;
        my $m = int(($t+$b)/2);
        while ($b+1 < $t) {
            if    ($n == $N->[$m])  {   return $m;  }
            elsif ($n <  $N->[$m])  {   $t = $m;    }
            else                    {   $b = $m;    }
            $m = int(($t+$b)/2);
        }

        # not found, insert at $m+1
        splice(@$N, $m+1, 0, $n);
        return $m+1;
    }
}

# main
my($n, @N) = @ARGV;
my $pos = search_insert($n, \@N);
say $pos;
say "(",join(", ", @N).")";
