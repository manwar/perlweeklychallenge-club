#!/usr/bin/env perl
#
# ch-2.pl - Split number
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
use Carp;
no warnings 'uninitialized';

die "Usage: $0 square_number\n" if @ARGV == 0;
split_num($ARGV[0]);

# Takes a perfect square and outputs all possible partitionings of that
# number which sum to its square root. For example 99*99 = 9801
# 98 + 0 + 1 = 99.
# The task description asked for only a boolean return if any partitions
# satisfied the requirement, but I've arbitrarily decided to spice things
# up by printing out all matching partitions. This adds a bit of housekeeping
# to the code, but it's not that bad.
sub split_num {
    my $sq = shift;
    my $n = sqrt($sq);
    croak "$sq is not a perfect square" if $n != int $n;

    # The splits can be represented by a binary number of length($n)-1,
    # where 0 = don't split, and 1 = split
    my $bits = length($sq)-1;
    my $max = 2**$bits;

    # Start at 1 because 0 would not give us "two or more" splits
BIN:for my $bin (1..$max) {
        my $sum = 0; # Track partial sum for optimization
        my $num = '';
        my @sum;
        for my $bit (0..$bits) {
            next if $num eq '0'; # No leading zeroes
            $num .= substr $sq, $bit, 1;

            if ($bin & (1 << $bit)) {
                push @sum, $num;
                $sum += $num;
                next BIN if $sum > $n;
                $num = '';
            }
        }
        push @sum, $num;
        $sum += $num;
        next if $sum != $n;

        printf "%30s = %10d\n", join(' + ', @sum), $sum
            if $sum = $n;
    }
}
