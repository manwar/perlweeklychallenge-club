#!/usr/bin/env perl

# Challenge 357
#
# Task 2: Unique Fraction Generator
# Submitted by: Yary
# Given a positive integer N, generate all unique fractions you can create using integers from 1 to N and follow the rules below:
#
# - Use numbers 1 through N only (no zero)
# - Create fractions like numerator/denominator
# - List them in ascending order (from smallest to largest)
# - If two fractions have the same value (like 1/2 and 2/4),
# only show the one with the smallest numerator
# Example 1
# Input: $int = 3
# Output: 1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1
# Example 2
# Input: $int = 4
# Output: 1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1
#
# Example 3
# Input: $int = 1
# Output: 1/1
#
# Example 4
# Input: $int = 6
# Output: 1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4,
# 4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1,
# 5/2, 3/1, 4/1, 5/1, 6/1
#
# Example 5
# Input: $int = 5
# Output: 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1,
# 5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1

use Modern::Perl;

@ARGV==1 or die "usage: $0 num\n";
my @fracts = fracts($ARGV[0]);
say join ", ", map {$_->[1]} sort {$a->[0]<=>$b->[0]} @fracts;

sub fracts {
    my($N) = @_;
    my @fracts;
    my %seen;
    for my $den (1 .. $N) {
        for my $num (1 .. $N) {
            my $value = $num/$den;
            if (!$seen{$value}++) {
                push @fracts, [$value, "$num/$den"];
            }
        }
    }
    return @fracts;
}


