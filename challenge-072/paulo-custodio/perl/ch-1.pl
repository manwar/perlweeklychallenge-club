#!/usr/bin/env perl

# Challenge 072
#
# TASK #1 › Trailing Zeroes
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N (<= 10).
#
# Write a script to print number of trailing zeroes in $N!.
#
# Example 1
# Input: $N = 10
# Output: 2 as $N! = 3628800 has 2 trailing zeroes
#
# Example 2
# Input: $N = 7
# Output: 1 as $N! = 5040 has 1 trailing zero
#
# Example 3
# Input: $N = 4
# Output: 0 as $N! = 24 has 0 trailing zero

use Modern::Perl;

my $N = shift||1;
say trailing_zeros(fact($N));


sub fact {
    my($n) = @_;
    if ($n < 2) {
        return 1;
    }
    else {
        return $n*fact($n-1);
    }
}

sub trailing_zeros {
    my($n) = @_;
    $n =~ /(0*)$/;
    return length($1);
}
