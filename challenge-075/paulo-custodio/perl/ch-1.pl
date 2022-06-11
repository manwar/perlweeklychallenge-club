#!/usr/bin/env perl

# Challenge 075
#
# TASK #1 › Coins Sum
# Submitted by: Mohammad S Anwar
# You are given a set of coins @C, assuming you have infinite amount of each
# coin in the set.
#
# Write a script to find how many ways you make sum $S using the coins from
# the set @C.
#
# Example:
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

use Modern::Perl;
use List::Util qw( sum0 );

my($S, @C) = @ARGV;

show_coins($S, [], \@C, {});

sub show_coins {
    my($want, $have, $coins, $seen) = @_;
    my $sum_have = sum0(@$have);
    if ($sum_have > $want) {
        # busted sum
    }
    elsif ($sum_have == $want) {
        my $out = join(", ", sort {$a<=>$b} @$have);
        say $out unless $seen->{$out}++;
    }
    else {
        for my $coin (@$coins) {
            show_coins($want, [@$have, $coin], $coins, $seen);
        }
    }
}
