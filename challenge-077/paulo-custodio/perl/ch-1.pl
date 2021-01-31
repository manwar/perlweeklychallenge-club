#!/usr/bin/perl

# Challenge 077
#
# TASK #1 › Fibonacci Sum
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N.
#
# UPDATE: 2020-09-07 09:00:00
# Write a script to find out all possible combination of Fibonacci Numbers required to get $N on addition.
#
# You are NOT allowed to repeat a number. Print 0 if none found.
#
# Example 1:
# Input: $N = 6
#
# Output:
#     1 + 2 + 3 = 6
#     1 + 5 = 6
# Example 2:
# Input: $N = 9
#
# Output:
#     1 + 8 = 9
#     1 + 3 + 5 = 9

use strict;
use warnings;
use 5.030;
use Math::Combinatorics;

my($N) = shift;

# compute list of Fibonacci numbers up to input
my @fib = (0, 1);
compute_fib($N);

# terms for addition are the Fibonacci numbers except the first two terms (0,1)
my @terms = @fib[2 .. $#fib];

my @out;
for my $k (1 .. scalar(@terms)) {
    my $combinat = Math::Combinatorics->new(count => $k, data => \@terms);
    while(my @set = $combinat->next_combination) {
        if (sum(@set) == $N) {
            push @out, join(" + ", sort @set)." = $N\n";
        }
    }
}

# sort result so that it is deterministic
print sort(@out);


sub compute_fib {
    my($target) = @_;
    while ($fib[-1] < $target) {
        push @fib, $fib[-1]+$fib[-2];
    }
}

sub sum {
    my($sum, @a) = @_;
    $sum += $_ for @a;
    return $sum;
}
