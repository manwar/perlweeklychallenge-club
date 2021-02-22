#!/usr/bin/perl

# Challenge 081
#
# TASK #1 › Common Base String
# Submitted by: Mohammad S Anwar
# You are given 2 strings, $A and $B.
#
# Write a script to find out common base strings in $A and $B.
#
# A substring of a string $S is called base string if repeated concatenation
# of the substring results in the string.
#
# Example 1:
# Input:
#     $A = "abcdabcd"
#     $B = "abcdabcdabcdabcd"
#
# Output:
#     ("abcd", "abcdabcd")
# Example 2:
# Input:
#     $A = "aaa"
#     $B = "aa"
#
# Output:
#     ("a")

use strict;
use warnings;
use 5.030;
use Array::Utils 'intersect';

@ARGV==2 or die "Usage: ch-1.pl A B\n";
my($A, $B) = @ARGV;
my @base_a = base_strings($A);
my @base_b = base_strings($B);
my @result = intersect(@base_a, @base_b);
say "(", join(", ", map {'"'.$_.'"'} @result), ")";


sub base_strings {
    my($str) = @_;
    my @base;

    my $len = length($str);
    for my $i (1 .. $len) {
        if ($len % $i == 0) {   # $i is a divisor of total length
            my $base = substr($str, 0, $i);
            if (($base x ($len / $i)) eq $str) {
                push @base, $base;
            }
        }
    }
    return @base;
}
