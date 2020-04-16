#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-056/
# Task #2
#
# Path Sum
# You are given a binary tree and a sum, write a script to find
# if the tree has a path such that adding up all the values along the path
# equals the given sum. Only complete paths (from root to leaf node)
# may be considered for a sum.
#
# Example
# Given the below binary tree and sum = 22,
#
#           5
#          / \
#         4   8
#        /   / \
#       11  13  9
#      /  \      \
#     7    2      1
# For the given binary tree, the partial path sum 5 -> 8 -> 9 = 22 is not valid.
#
# The script should return the path 5 -> 4 -> 11 -> 2 whose sum is 22.

use strict;
use warnings;

my $sum = shift || 22;

my $tree = {
            v => 5,
            l => {
                v => 4,
                l => {
                    v => 11,
                    l => { v => 7 },
                    r => { v => 2 }
                }
            },
            r => {
                v => 8,
                l => { v=> 13 },
                r => {
                    v => 9,
                    r => { v => 1}
                }
            }
};

travel($tree);

sub travel {
    my $node = shift;
    my $path = shift // [];

    push @$path, $node->{v};

    if (1 == scalar keys %$node) {
        my $s = 0;
        $s += $_ for @$path;
        print join(' -> ',@$path).$/ if $s == $sum;
    }
    else {
        foreach my $k ('l','r'){
            next unless exists $node->{$k};
            travel($node->{$k},$path);
            pop @$path;
        }
    }

}

__END__

./ch-2.pl 22
5 -> 4 -> 11 -> 2

./ch-2.pl 26
5 -> 8 -> 13
