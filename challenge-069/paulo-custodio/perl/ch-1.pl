#!/usr/bin/env perl

# Challenge 069
#
# TASK #1 › Strobogrammatic Number
# Submitted by: Mohammad S Anwar
# A strobogrammatic number is a number that looks the same when looked at upside
# down.
#
# You are given two positive numbers $A and $B such that 1 <= $A <= $B <= 10^15.
#
# Write a script to print all strobogrammatic numbers between the given two
# numbers.
#
# Example
# Input: $A = 50, $B = 100
#     Output: 69, 88, 96

use Modern::Perl;

my($A, $B) = @ARGV;
my @out;
for my $n ($A .. $B) {
    push @out, $n if is_strobogrammatic($n);
}
say join(", ", @out);

sub is_strobogrammatic {
    my($n) = @_;
    $n =~ /^[0689]+$/ or return 0;
    (my $inv = $n) =~ tr/69/96/;
    return 1 if reverse($inv)==$n;
    return 0;
}
