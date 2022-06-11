#!/usr/bin/env perl

# Challenge 066
#
# TASK #2 › Power Integers
# Submitted by: Mohammad S Anwar
#
# You are given an integer $N.
#
# Write a script to check if the given number can be expressed as mn where m and
# n are positive integers. Otherwise print 0.
#
# Please make sure m > 1 and n > 1.
#
# BONUS: If there are more than one ways to express the given number then print
# all possible solutions.
#
# Example 1:
# For given $N = 9, it should print 32 or 3^2.
#
# Example 2:
# For given $N = 45, it should print 0.
#
# Example 3:
# For given $N = 64, it should print all or one of 8^2 or 2^6 or 4^3.

use Modern::Perl;

my $N = shift||0;
show_powers($N);

sub show_powers {
    my($n) = @_;
    my $has_solution;
    for my $b (2..sqrt($n)) {
        for my $e (2..$n) {
            if ($b ** $e == $n) {
                say "$b^$e";
                $has_solution=1;
            }
        }
    }
    say "0" if !$has_solution;
}
