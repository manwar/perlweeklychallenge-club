#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 084 Task #1 > Reverse Integer
#=============================================================================
# You are given an integer $N.
# Write a script to reverse the given integer and print the result.
# Print 0 if the result doesn’t fit in 32-bit signed integer.
# The number 2,147,483,647 is the maximum positive value for a 32-bit signed binary integer in computing.

use strict;
use warnings;
use v5.30;

use experimental qw/ signatures /;


sub Usage { "Usage: $0 args" };

my $N = shift;

die Usage() unless $N;

my $sign = 1;
if ( $N < 0 )
{
    $sign = -1;
    $N = -$N;
}

# Adding 0 forces numeric, drops leading zeroes.
my $revN = 0 + reverse($N);

if ( ($revN > 0x7fffffff) )
{
    say 0;
}
else
{
    say $sign * $revN;
}
