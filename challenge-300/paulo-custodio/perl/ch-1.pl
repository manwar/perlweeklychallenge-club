#!/usr/bin/env perl

# Challenge 300
#
# Task 1: Beautiful Arrangement
# Submitted by: Mohammad Sajid Anwar
# You are given a positive integer, $int.
#
# Write a script to return the number of beautiful arrangements that you can construct.
#
# A permutation of n integers, 1-indexed, is considered a beautiful arrangement
# if for every i (1 <= i <= n) either of the following is true:
#
# 1) perm[i] is divisible by i
# 2) i is divisible by perm[i]
# Example 1
# Input: $n = 2
# Output: 2
#
# 1st arrangement: [1, 2]
#     perm[1] is divisible by i = 1
#     perm[2] is divisible by i = 2
# 2nd arrangement: [2, 1]
#     perm[1] is divisible by i = 1
#     i=2 is divisible by perm[2] = 1
# Example 2
# Input: $n = 1
# Output: 1
# Example 3
# Input: $n = 10
# Output: 700

use Modern::Perl;

@ARGV==1 or die "usage: $0 N\n";
my $N = 0+$ARGV[0];

sub permute {
    my(@items) = @_;
    my @output;

    my $permute;
    $permute = sub {
        my($items, $perms) = @_;
        unless (@$items) {
            push @output, $perms;
            return;
        }
        for my $i (0 .. $#$items) {
            my @rest = @$items;
            my ($pick) = splice(@rest, $i, 1);
            $permute->(\@rest, [@$perms, $pick]);
        }
    };

    $permute->(\@items, []);
    return @output;
}

sub is_beautiful {
    my(@items) = @_;
    for my $i (1 .. @items) {
        return 0 if $items[$i-1] % $i != 0 && $i % $items[$i-1] != 0;
    }
    return 1;
}

my @output = grep {is_beautiful(@$_)} permute(1..$N);
say scalar(@output);
