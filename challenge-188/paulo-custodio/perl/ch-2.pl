#!/usr/bin/perl

# Challenge 188
#
# Task 2: Total Zero
# Submitted by: Mohammad S Anwar
# You are given two positive integers $x and $y.
#
# Write a script to find out the number of operations needed to make both ZERO.
# Each operation is made up either of the followings:
#
# $x = $x - $y if $x >= $y
#
# or
#
# $y = $y - $x if $y >= $x (using the original value of $x)
# Example 1
# Input: $x = 5, $y = 4
# Output: 5
# Example 2
# Input: $x = 4, $y = 6
# Output: 3
# Example 3
# Input: $x = 2, $y = 5
# Output: 4
# Example 4
# Input: $x = 3, $y = 1
# Output: 3
# Example 5
# Input: $x = 7, $y = 4
# Output: 5

use Modern::Perl;

sub total_zero {
    my($x,$y)=@_;
    die if $x<=0 || $y<=0;
    my $count=0;
    while ($x>0 && $y>0) {
        if ($x==$y) {       $x=$y=0;    }
        elsif ($x>$y) {     $x-=$y;     }
        else {              $y-=$x;     }
        $count++;
    }
    return $count;
}

say total_zero(@ARGV);
