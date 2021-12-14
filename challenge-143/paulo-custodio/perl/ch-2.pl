#!/usr/bin/perl

# TASK #2 > Stealthy Number
# Submitted by: Mohammad S Anwar
# You are given a positive number, $n.
#
# Write a script to find out if the given number is Stealthy Number.
#
# A positive integer N is stealthy, if there exist positive integers a, b, c, d
# such that a * b = c * d = N and a + b = c + d + 1.
#
# Example 1
# Input: $n = 36
# Output: 1
#
# Since 36 = 4 (a) * 9 (b) = 6 (c) * 6 (d) and 4 (a) + 9 (b) = 6 (c) + 6 (d) + 1.
# Example 2
# Input: $n = 12
# Output: 1
#
# Since 2 * 6 = 3 * 4 and 2 + 6 = 3 + 4 + 1
# Example 3
# Input: $n = 6
# Output: 0
#
# Since 2 * 3 = 1 * 6 but 2 + 3 != 1 + 6 + 1

use Modern::Perl;

sub is_stealthy {
    my($n) = @_;
    for my $a (1..$n) {
        if ($n % $a == 0) {
            my $b = $n / $a;            # a*b=n
            for my $c (1..$n) {
                if ($n % $c == 0) {
                    my $d = $n / $c;    # c*d=n
                    if ($a+$b==$c+$d+1) {
                        return 1;
                    }
                }
            }
        }
    }
    return 0;
}

my $n = shift//1;
say is_stealthy($n);
