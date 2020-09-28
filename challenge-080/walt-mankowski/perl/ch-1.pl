#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #1 › Smallest Positive Number Bits
# Submitted by: Mohammad S Anwar
#
# You are given unsorted list of integers @N.
#
# Write a script to find out the smallest positive number missing.

my %h = map { $_ => 1 } @ARGV;

my $n = 1;
while (1) {
    if (defined $h{$n}) {
        $n++;
    } else {
        say $n;
        last;
    }
}
