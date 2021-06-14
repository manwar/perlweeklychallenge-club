#!/usr/bin/env perl

# Challenge 114
#
# TASK #1 - Next Palindrome Number
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N.
#
# Write a script to find out the next Palindrome Number higher than the given
# integer $N.
#
# Example
# Input: $N = 1234
# Output: 1331
#
# Input: $N = 999
# Output: 1001

use Modern::Perl;

my $N = shift || 0;
say next_palindrome($N);

sub is_palindrome {
    my($n) = @_;
    return reverse($n)==$n;
}

sub next_palindrome {
    my($n) = @_;
    while (1) {
        $n++;
        return $n if is_palindrome($n);
    }
}
