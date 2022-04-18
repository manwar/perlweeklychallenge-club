#!/usr/bin/env perl

# Challenge 049
#
# TASK #1
# Smallest Multiple
# Write a script to accept a positive number as command line argument and print
# the smallest multiple of the given number consists of digits 0 and 1.
#
# For example:
#
# For given number 55, the smallest multiple is 110 consisting of digits 0 and 1.

use Modern::Perl;

say smallest_multiple(shift||1);

sub smallest_multiple {
    my($n) = @_;
    my $v = $n;
    while ($v !~ /^[01]+$/) {
        $v += $n;
    }
    return $v;
}
