#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #1 › Reverse Integer
# Submitted by: Mohammad S Anwar
#
# You are given an integer $N.
#
# Write a script to reverse the given integer and print the
# result. Print 0 if the result doesn’t fit in 32-bit signed integer.
#
# The number 2,147,483,647 is the maximum positive value for a 32-bit
# signed binary integer in computing.

my $n = shift @ARGV;
if ($n >= 0) {
    my $result = scalar reverse $n;
    say $result > 2**31 - 1 ? 0 : $result;
} else {
    my $result = "-" . scalar reverse abs $n;
    say $result < -(2**31) ? 0 : $result;
}
