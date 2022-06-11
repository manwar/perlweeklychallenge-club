#!/usr/bin/env perl

# Challenge 052
#
# TASK #1
# Stepping Numbers
# Write a script to accept two numbers between 100 and 999. It should then print
# all Stepping Numbers between them.
#
# A number is called a stepping number if the adjacent digits have a difference
# of 1. For example, 456 is a stepping number but 129 is not.

use Modern::Perl;

my($start, $end) = @ARGV;
for my $n (123, 234, 345, 456, 567, 678, 789) {
    say $n if $n >= $start && $n <= $end;
}
