#!/usr/bin/perl

# TASK #1 > Divisor Last Digit
# Submitted by: Mohammad S Anwar
# You are given positive integers, $m and $n.
#
# Write a script to find total count of divisors of $m having last digit $n.
#
#
# Example 1:
# Input: $m = 24, $n = 2
# Output: 2
#
# The divisors of 24 are 1, 2, 3, 4, 6, 8 and 12.
# There are only 2 divisors having last digit 2 are 2 and 12.
#
# Example 2:
# Input: $m = 30, $n = 5
# Output: 2
#
# The divisors of 30 are 1, 2, 3, 5, 6, 10 and 15.
# There are only 2 divisors having last digit 5 are 5 and 15.

use Modern::Perl;

sub divisors {
    my($n) = @_;
    my(@div_low, @div_high);
    for (my $i = 1; $i <= sqrt($n); $i++) {
        if ($n%$i == 0) {
            push @div_low, $i;
            unshift @div_high, $n/$i if $n/$i != $i;
        }
    }
    return (@div_low, @div_high);
}

my($m, $n) = @ARGV;
my @divisors = divisors($m);
my $count = scalar grep {/$n$/} @divisors;
say $count;
