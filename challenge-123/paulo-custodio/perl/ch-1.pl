#!/usr/bin/env perl

# TASK #1 > Ugly Numbers
# Submitted by: Mohammad S Anwar
# You are given an integer $n >= 1.
#
# Write a script to find the $nth element of Ugly Numbers.
#
# Ugly numbers are those number whose prime factors are 2, 3 or 5. For example,
# the first 10 Ugly Numbers are 1, 2, 3, 4, 5, 6, 8, 9, 10, 12.
#
# Example
# Input: $n = 7
# Output: 8
#
# Input: $n = 10
# Output: 12

use Modern::Perl;
use List::Util 'min';

# return an iterator to generate the sequence
# the sequence is a merge of all multiples of 2, 3 and 5
sub hamming_gen {
    # sequences of hamming numbers 2*n, 3*n, 5*n
    my @seq = ([1], [1], [1]);
    my @base = (2, 3, 5);

    return sub {
        # get the smallest of the multiples
        my $n = min($seq[0][0], $seq[1][0], $seq[2][0]);
        for my $i (0..2) {
            # shift used multiples
            shift @{$seq[$i]} if $seq[$i][0] == $n;
            # push next multiple
            push @{$seq[$i]}, $n*$base[$i];
        }
        return $n;
    }
}

my($n) = @ARGV;
my $hamming = hamming_gen();
for (1 .. $n) {
    say $hamming->();
}
