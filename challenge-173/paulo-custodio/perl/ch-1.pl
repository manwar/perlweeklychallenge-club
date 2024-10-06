#!/usr/bin/env perl

# Challenge 173
#
# Task 1: Esthetic Number
# Submitted by: Mohammad S Anwar
#
# You are given a positive integer, $n.
#
# Write a script to find out if the given number is Esthetic Number.
#
#     An esthetic number is a positive integer where every adjacent digit differs
#     from its neighbour by 1.
#
#
# For example,
#
# 5456 is an esthetic number as |5 - 4| = |4 - 5| = |5 - 6| = 1
# 120 is not an esthetic numner as |1 - 2| != |2 - 0| != 1

use Modern::Perl;

sub is_esthetic {
    my($n) = @_;
    my @n = split //, $n;
    while (@n > 1) {
        return 0 if abs($n[0] - $n[1]) != 1;
        shift @n;
    }
    return 1;
}

@ARGV==1 or die "usage: ch-1.pl n\n";
say is_esthetic(shift);
