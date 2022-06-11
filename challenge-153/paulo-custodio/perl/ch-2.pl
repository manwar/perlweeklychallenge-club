#!/usr/bin/env perl

# Challenge 153
#
# TASK #2 › Factorions
# Submitted by: Mohammad S Anwar
# You are given an integer, $n.
#
# Write a script to figure out if the given integer is factorion.
#
# A factorion is a natural number that equals the sum of the factorials
# of its digits.
#
# Example 1:
# Input: $n = 145
# Output: 1
#
#     Since 1! + 4! + 5! => 1 + 24 + 120 = 145
# Example 2:
# Input: $n = 123
# Output: 0
#
#     Since 1! + 2! + 3! => 1 + 2 + 6 <> 123

use Modern::Perl;
use List::Util qw( sum );

my $n = shift or die "Usage: ch-2.pl N\n";
say is_factorian($n);


sub fact {
    my($n) = @_;
    if ($n < 2) {
        return 1;
    }
    else {
        return $n * fact($n-1);
    }
}

sub is_factorian {
    my($n) = @_;
    my @digits = split //, $n;
    my @fact = map { fact($_) } @digits;
    if (sum(@fact) == $n) {
        return 1;
    }
    else {
        return 0;
    }
}
