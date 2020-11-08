#!/usr/bin/env perl

use Modern::Perl;

# TASK #1 › Triplet Sum
# Submitted by: Mohammad S Anwar
# You are given an array of real numbers greater than zero.

# Write a script to find if there exists a triplet (a,b,c) such that 1 < a+b+c < 2. Print 1 if you succeed otherwise 0.

# Example 1:
# Input: @R = (1.2, 0.4, 0.1, 2.5)
# Output: 1 as 1 < 1.2 + 0.4 + 0.1 < 2
# Example 2:
# Input: @R = (0.2, 1.5, 0.9, 1.1)
# Output: 0
# Example 3:
# Input: @R = (0.5, 1.1, 0.3, 0.7)
# Output: 1 as 1 < 0.5 + 1.1 + 0.3 < 2

my @R = @ARGV;

for my $a (@R) {    # choose a from the list of numbers
    my @R = grep { $_ != $a } @R;    # remaining numbers, without the a we chose
    for my $b (@R) {                 # choose b from the remainder
        my @R = grep { $_ != $b } @R;    # remaining numbers, without the a and b we chose
        for my $c (@R) {                 # choose c from the remainder
            my $sum = $a + $b + $c;      # do the validation
            if ( 1 < $sum && $sum < 2 ) {
                say 1;
                exit;
            }
        }
    }
}
say 0;
