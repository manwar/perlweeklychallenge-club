#!/usr/bin/perl

# Challenge 201
#
# Task 2: Penny Piles
# Submitted by: Robbie Hatley
#
# You are given an integer, $n > 0.
#
# Write a script to determine the number of ways of putting $n pennies in a row
# of piles of ascending heights from left to right.
# Example
#
# Input: $n = 5
# Output: 7
#
# Since $n=5, there are 7 ways of stacking 5 pennies in ascending piles:
#
#     1 1 1 1 1
#     1 1 1 2
#     1 2 2
#     1 1 3
#     2 3
#     1 4
#     5

use Modern::Perl;
no warnings 'recursion';

sub make_piles1 {
    my($count, $prev, $n) = @_;
    my @prev = @$prev;
    if ($n < 0) {
    }
    elsif ($n == 0) {
        #say "@prev";
        $$count++;
    }
    else {
        my $max = @prev==0 ? $n : $prev[-1];
        for my $i (1..$max) {
            make_piles1($count, [@prev, $i], $n-$i);
        }
    }
}

sub make_piles {
    my($n) = @_;
    my $count = 0;
    make_piles1(\$count, [], $n);
    return $count;
}

@ARGV==1 or die "usage: ch-2.pl n\n";
my($n) = @ARGV;
say make_piles($n);
