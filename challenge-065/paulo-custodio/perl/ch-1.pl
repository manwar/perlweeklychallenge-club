#!/usr/bin/env perl

# Challenge 065
#
# TASK #1 › Digits Sum
# Submitted by: Mohammad S Anwar
# Reviewed by: Ryan Thompson
#
# You are given two positive numbers $N and $S.
#
# Write a script to list all positive numbers having exactly $N digits where sum
# of all digits equals to $S.
#
# Example
# Input:
#     $N = 2
#     $S = 4
#
# Output:
#     13, 22, 31, 40

use Modern::Perl;
use List::Util 'sum';

my($N, $S) = @ARGV;
my @out = digits_sum($N, $S);
say join(", ", @out);


sub digits_sum {
    my($N, $S) = @_;
    my @out;
    for my $n (10 ** ($N-1) .. (10 ** $N)-1) {
        my @d = split //, $n;
        push @out, $n if sum(@d)==$S;
    }
    return @out;
}
