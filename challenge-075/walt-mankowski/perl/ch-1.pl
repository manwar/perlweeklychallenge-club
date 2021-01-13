#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #1 › Coins Sum
# Submitted by: Mohammad S Anwar
#
# You are given a set of coins @C, assuming you have infinite amount of each coin in the set.
#
# Write a script to find how many ways you make sum $S using the coins from the set @C.
# Example:
#
# Input:
#     @C = (1, 2, 4)
#     $S = 6
#
# Output: 6
# There are 6 possible ways to make sum 6.
# a) (1, 1, 1, 1, 1, 1)
# b) (1, 1, 1, 1, 2)
# c) (1, 1, 2, 2)
# d) (1, 1, 4)
# e) (2, 2, 2)
# f) (2, 4)

my $s = shift @ARGV;
my @c = @ARGV;
my @solutions;

my @cnt = map {0} 0..$#c;
while (1) {
    my $val = value(\@c, \@cnt);
    if ($val >= $s) {
        if ($val == $s) {
            my @tmp = @cnt;
            push @solutions, \@tmp;
        }

        # rotate "odometer"
        $cnt[-1] = 0;
        my $i = -2;
        $cnt[$i]++;
        while ($i >= -@c && value(\@c, \@cnt) > $s) {
            $cnt[$i] = 0;
            $i--;
            $cnt[$i]++ if $i >= -@c;
        }
        last if $i < -@c;
    } else {
        $cnt[-1]++;
    }
}

# print out the solutions
say "There are " . scalar @solutions . " ways to make sum $s";
for my $sol (@solutions) {
    my @tmp;
    for my $i (0..$#c) {
        push @tmp, $c[$i] for 0..$sol->[$i]-1;
    }
    say "@tmp";
}

sub value($c, $cnt) {
    my $sum = 0;
    for my $i (0..$#$c) {
        $sum += $c->[$i] * $cnt->[$i];
    }
    return $sum;
}
