#!/usr/bin/env perl

# Challenge 136
#
# TASK #2 > Fibonacci Sequence
# Submitted by: Mohammad S Anwar
# You are given a positive number $n.
#
# Write a script to find how many different sequences you can create using
# Fibonacci numbers where the sum of unique numbers in each sequence are the
# same as the given number.
#
# Fibonacci Numbers: 1,2,3,5,8,13,21,34,55,89, ...
#
# Example 1
# Input:  $n = 16
# Output: 4
#
# Reason: There are 4 possible sequences that can be created using Fibonacci
# numbers
# i.e. (3 + 13), (1 + 2 + 13), (3 + 5 + 8) and (1 + 2 + 5 + 8).
# Example 2
# Input:  $n = 9
# Output: 2
#
# Reason: There are 2 possible sequences that can be created using Fibonacci
# numbers
# i.e. (1 + 3 + 5) and (1 + 8).
# Example 3
# Input:  $n = 15
# Output: 2
#
# Reason: There are 2 possible sequences that can be created using Fibonacci
# numbers
# i.e. (2 + 5 + 8) and (2 + 13).

use Modern::Perl;
use Math::Fibonacci 'term';
use Math::Combinatorics;
use List::Util 'sum';

@ARGV or die "Usage: ch-2.pl n\n";
my $n = shift;
my @fibs = fibonacci_upto($n);
say count_combin_sum($n, @fibs);


sub fibonacci_upto {
    my($n) = @_;
    my @fibs;
    my $i = 2;      # skip first '1'
    do {
        push @fibs, term($i++);
    } while ($fibs[-1] < $n);
    pop @fibs if $fibs[-1] > $n;
    return @fibs;
}

sub count_combin_sum {
    my($n, @terms) = @_;
    my $count = 0;
    for my $k (1..@terms) {
        my @combin = combine($k, @terms);
        for (@combin) {
            my @combo = @$_;
            if (sum(@combo) == $n) {
                $count++;
            }
        }
    }
    return $count;
}
