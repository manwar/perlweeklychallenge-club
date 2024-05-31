#!/usr/bin/env perl

# Task 2: Sort by 1 bits
# Submitted by: Mohammad Sajid Anwar
# 
# You are give an array of integers, @ints.
# Write a script to sort the integers in ascending order by the number of 1 bits in their binary representation. In case more than one integers have the same number of 1 bits then sort them in ascending order.
#
# Example 1
# Input: @ints = (0, 1, 2, 3, 4, 5, 6, 7, 8)
# Output: (0, 1, 2, 4, 8, 3, 5, 6, 7)
# 
# 0 = 0 one bits
# 1 = 1 one bits
# 2 = 1 one bits
# 4 = 1 one bits
# 8 = 1 one bits
# 3 = 2 one bits
# 5 = 2 one bits
# 6 = 2 one bits
# 7 = 3 one bits
# 
# Example 2
# Input: @ints = (1024, 512, 256, 128, 64)
# Output: (64, 128, 256, 512, 1024)
# 
# All integers in the given array have one 1-bits, so just sort them in ascending order.

use strict;
use warnings;
use List::Util qw/ sum /;

my @ints = (0, 1, 2, 3, 4, 5, 6, 7, 8);
sort_by_1_bits(\@ints);

@ints = (1024, 512, 256, 128, 64);
sort_by_1_bits(\@ints);

exit 0;

sub sort_by_1_bits {
    my $ints = shift;

    my %binary;
    foreach my $int (@ints) {
        push @{ $binary{ sum split //, sprintf '%b', $int } }, $int;
    }
    printf " (%s) -> (%s)\n",
        ( join ', ', @ints ),
        ( join ', ', map { sort { $a <=> $b } @{ $binary{$_} } }
            sort { $a <=> $b } keys %binary
        );
}
