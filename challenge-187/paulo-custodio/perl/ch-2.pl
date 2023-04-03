#!/usr/bin/perl

# Challenge 187
#
# Task 2: Magical Triplets
# Submitted by: Mohammad S Anwar
#
# You are given a list of positive numbers, @n, having at least 3 numbers.
#
# Write a script to find the triplets (a, b, c) from the given list that
# satisfies the following rules.
#
# 1. a + b > c
# 2. b + c > a
# 3. a + c > b
# 4. a + b + c is maximum.
#
# In case, you end up with more than one triplets having the maximum then pick
# the triplet where a >= b >= c.
#
# Example 1
#
#     Input: @n = (1, 2, 3, 2);
#     Output: (3, 2, 2)
#
# Example 2
#
#     Input: @n = (1, 3, 2);
#     Output: ()
#
# Example 3
#
#     Input: @n = (1, 1, 2, 3);
#     Output: ()
#
# Example 4
#
#     Input: @n = (2, 4, 3);
#     Output: (4, 3, 2)

use Modern::Perl;
use List::Util 'sum';

sub triplets {
    my(@n) = @_;
    my @result;
    for my $ai (0..$#n) {
        my $a = $n[$ai];
        for my $bi (0..$#n) {
            next if $bi == $ai;
            my $b = $n[$bi];
            for my $ci (0..$#n) {
                next if $ci == $bi || $ci == $ai;
                my $c = $n[$ci];
                next unless $a+$b>$c;
                next unless $b+$c>$a;
                next unless $a+$c>$b;
                if (!@result || sum(@result) < sum($a, $b, $c)) {
                    @result = ($a, $b, $c);
                }
            }
        }
    }
    return sort {$b <=> $a} @result;
}

@ARGV or die "usage: ch-2.pl list...\n";
say "(", join(", ", triplets(@ARGV)), ")";
