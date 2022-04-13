#!/usr/bin/env perl

# Challenge 054
#
# TASK #2
# Collatz Conjecture
# Contributed by Ryan Thompson
# It is thought that the following sequence will always reach 1:
#
# $n = $n / 2 when $n is even
# $n = 3*$n + 1 when $n is odd
# For example, if we start at 23, we get the following sequence:
#
# 23 ? 70 ? 35 ? 106 ? 53 ? 160 ? 80 ? 40 ? 20 ? 10 ? 5 ? 16 ? 8 ? 4 ? 2 ? 1
#
# Write a function that finds the Collatz sequence for any positive integer.
# Notice how the sequence itself may go far above the original starting number.
#
# Extra Credit
# Have your script calculate the sequence length for all starting numbers up to
# 1000000 (1e6), and output the starting number and sequence length for the
# longest 20 sequences.

use Modern::Perl;

my @longest;
for my $n (1..1e6) {
    my @seq = collatz($n);
    my $len = scalar(@seq);
    push @longest, [$n => $len];
    @longest = sort {$b->[1] <=> $a->[1]} @longest;
    pop @longest if @longest > 20;
}

for (@longest) {
    my($n, $len) = @$_;
    say "$n $len";
}

sub collatz {
    my($n) = @_;
    my @out = ($n);
    while ($n != 1) {
        if ($n%2==0) {
            $n /= 2;
        }
        else {
            $n = 3*$n+1;
        }
        push @out, $n;
    }
    return @out;
}
